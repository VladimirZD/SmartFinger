


using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Shapes;
using Microsoft.Phone.Controls;
using Microsoft.Expression.Shapes;
using System.Windows.Threading;
using System.Collections.Generic;
using Igra.Effects;
using Microsoft.Xna.Framework.Audio;
//using System.Windows.Navigation;
using System.Windows.Resources;
using Microsoft.Devices;
using System.Windows.Controls.Primitives;
using Coding4Fun.Phone.Controls;
using Igra.Resources;



namespace Igra
{
    //TODO muzika i zvukovi
    //TODO mogućnost sviranja nešto od muzike na telefonu

    public partial class MainPage : PhoneApplicationPage
    {
        private enum StarStyleEnum
        {
            Inactive = 0,
            Solved = 1,
            Active = 2
        }

        private bool _newGame = false;

        //const int RESULTBONUS = 10;
        const string SOUND_CORRECT = "Blubup-Public_D-2.wav";
        const string SOUND_LEVELCOMPLETED = "RewardSo-Mark_E_B-1131.wav";
        const string SOUND_WRONG = "Wrong-public_d-269.wav";
        private DispatcherTimer _timer = null;
        private int _currentLevelIndex = 1;
        private int _currentStar = 1;
        private int _targetResult = 0;
        private int _currentSum = 0;
        private HighScore _hiscore;
        private IEffect _lastEffect;
       // private IEffect _wrongAnswer = new WrongAnswerEffect();
        private Color[] _timeColors = null;
        private int _colorChangeValue = 0;
        private List<Level> _levels;
        private Level _currentLevel;
        private List<int> _validNumbers;
        private DateTime _taskStartTime;
        private AppContext _appContext;
        private HighScore _score = null;

        public MainPage()
        {
            InitializeComponent();
            _timeColors = new Color[] { ColorProvider.CustomRed(), Colors.Yellow, ColorProvider.CustomGreen() };
            _colorChangeValue = (int)Math.Floor(AppContext.LEVELTIME / 3);
            textCurrentSum.Text=AppResources.SumText+" 0";
            //TODO ovo treba otkačiti pri deaktivaciji aplikacije
            this.LeftTextBlock.MouseLeftButtonDown += new MouseButtonEventHandler(OnNumberSelected);
            this.LeftShape.MouseLeftButtonDown += new MouseButtonEventHandler(OnNumberSelected);
            this.RightTextBlock.MouseLeftButtonDown += new MouseButtonEventHandler(OnNumberSelected);
            this.RightShape.MouseLeftButtonDown += new MouseButtonEventHandler(OnNumberSelected);
            this.TopTextBlock.MouseLeftButtonDown += new MouseButtonEventHandler(OnNumberSelected);
            this.TopShape.MouseLeftButtonDown += new MouseButtonEventHandler(OnNumberSelected);
            this.BottomTextBlock.MouseLeftButtonDown += new MouseButtonEventHandler(OnNumberSelected);
            this.BottomShape.MouseLeftButtonDown += new MouseButtonEventHandler(OnNumberSelected);
            _validNumbers = new List<int>();
            InitAppContext();
            InitTimer();
            _levels = LevelManager.GetLevels();
            SetupLevel();
        }

        private void InitAppContext()
        {
            AppContext.Instance = null; //resetramo staari
            _appContext = AppContext.Instance;

            _appContext.TextControls.Add(this.RightTextBlock);
            _appContext.TextControls.Add(this.LeftTextBlock);
            _appContext.TextControls.Add(this.TopTextBlock);
            _appContext.TextControls.Add(this.BottomTextBlock);
            _appContext.EllipseControls.Add(this.RightShape);
            _appContext.EllipseControls.Add(this.LeftShape);
            _appContext.EllipseControls.Add(this.TopShape);
            _appContext.EllipseControls.Add(this.BottomShape);
        }

        private void SetupLevel()
        {
            DeactivateAllStars();
            InitLevel();
        }

        void OnNumberSelected(object sender, MouseButtonEventArgs e)
        {
            TextBlock textBlock = null;
            Ellipse ellipse = null;

            if (sender.GetType().ToString() == "System.Windows.Controls.TextBlock")
            {
                textBlock = (TextBlock)sender;
                ellipse = GetEllipseByTextBlock(textBlock);
            }
            else
            {
                ellipse = (Ellipse)sender;
                textBlock = GetTextBlockByEllipse(ellipse);
            }
            OnItemSelected(textBlock, ellipse);
        }

        private void InitTimer()
        {
            _timer = new DispatcherTimer();
            _timer.Interval = new TimeSpan(0, 0, 1);
            _timer.Tick += new EventHandler(_timer_Tick);
        }

        private void InitLevel()
        {
            this.TimeProgress.Maximum = AppContext.LEVELTIME;
            if (!_newGame)
            {
                SetProgresBarValue(AppContext.Instance.CurrentProgress.Value);
                _newGame=true;
            }
            else
            {
                SetProgresBarValue(AppContext.LEVELTIME);
            }
            this.TimeProgress.Minimum = 0;
            DeselectAll();
            this.PageTitle.Text = AppResources.MainPageTitlePrefix + " " + _currentLevelIndex.ToString(); // "LEVEL " + _currentLevelIndex.ToString();
            GenerateTask();
            StartLevel();
        }

        private void StopAllEffects()
        {
           // _wrongAnswer.Stop();
            if (_currentLevel != null && _currentLevel.Effects != null)
            {
                foreach (IEffect effect in _currentLevel.Effects)
                {
                    effect.Stop();
                }
            }
        }

        private void SetProgresBarValue(double value)
        {
            this.TimeProgress.Value = value;
            SetProgressBarColor();
        }

        private void DeselectAll()
        {
            foreach (TextBlock item in _appContext.SelectedItems)
            {
                SetItemStyle(item, false);
            }
            _appContext.SelectedItems.Clear();
        }


        private void GenerateTask()
        {
            List<int> finalValues = new List<int>();
            List<int> originalValues = new List<int>();
            _currentLevel = _levels[_currentLevelIndex - 1];
            int index = 0;
            int number;

            int maxValue = _currentLevel.MaxValue;
            int minValue = _currentLevel.MinValue;
            int minElements = _currentLevel.MinElements;
            int maxElements = _currentLevel.MaxElements;


            //TODO: Logika generiranja brojeva koji idu u sumu je tanka, 
            Random generator = _appContext.RandomGenerator;
            SetStarStyle(_currentStar, StarStyleEnum.Active);
            ////svaka 3 nivoa povećavamo raspon brojeva i to za potenciju broja 10
            //int pow = (_currentLevel / 3) + 1;
            //int maxValue = (int)Math.Pow(10, pow)-1;
            //int minValue = -1 * maxValue;

            _targetResult = 0;
            _currentSum = 0;
            _validNumbers.Clear();

            while (index < 4)
            {
                number = generator.Next(minValue, maxValue + 1);
                if (number != 0 && originalValues.IndexOf(number) == -1)
                {
                    originalValues.Add(number);
                    index++;
                }
            }

            finalValues = new List<int>(originalValues);

            int elementCount = generator.Next(minElements, maxElements + 1);

            while (elementCount > 0)
            {
                index = generator.Next(0, originalValues.Count);
                _targetResult = _targetResult + originalValues[index];
                _validNumbers.Add(originalValues[index]);
                originalValues.RemoveAt(index);
                elementCount--;
            }

            this.LeftTextBlock.Text = finalValues[0].ToString();
            this.RightTextBlock.Text = finalValues[1].ToString();
            this.TopTextBlock.Text = finalValues[2].ToString();
            this.BottomTextBlock.Text = finalValues[3].ToString();
            this.ResultTextBlock.Text = _targetResult.ToString();

            textAllNumbers.Text = "";
            for (int n = 0; n < _validNumbers.Count; n++)
            {
                textAllNumbers.Text += _validNumbers[n].ToString() + ";";
            }
            _taskStartTime = DateTime.Now;
        }


        private void StartLevel()
        {
            _timer.Start();
        }

        void _timer_Tick(object sender, EventArgs e)
        {
            if (!(bool)AppContext.Instance.LearningMode.Value)
            {
                SetProgresBarValue(this.TimeProgress.Value - 1); //nije najsretniji način za pratiti vrijeme griješi tu i tamo..:)
            }
            if (this.TimeProgress.Value <= this.TimeProgress.Minimum)
            {
                StopLevel();
            }

            //prvih 5 sec nema niti jednog efekta
            double elapsed = (DateTime.Now - _taskStartTime).TotalSeconds;
            if (elapsed > 5 && (_lastEffect == null || !_lastEffect.Active))
            {
                IEffect effect = LevelManager.GetRandomEffect(_currentLevel);
                if (effect != null)
                {
                    effect.Execute();
                    _lastEffect = effect;
                }
            }

        }

        private void SetProgressBarColor()
        {
            int colorIndex = (int)(this.TimeProgress.Value / _colorChangeValue);
            if (colorIndex > 2) colorIndex = 2;
            this.TimeProgress.Foreground = new SolidColorBrush(_timeColors[colorIndex]);
        }

        private void SetStarStyle(int starIndex, StarStyleEnum style)
        {
            RegularPolygon star = (RegularPolygon)this.FindName("Star" + starIndex.ToString());
            Color fillColor = ColorProvider.CustomBlack();
            Color strokeColor = ColorProvider.StrokeActive();
            double strokeThickness = 1.5;
            switch (style)
            {
                case StarStyleEnum.Active:
                    fillColor = ColorProvider.CustomBlack(); ;
                    strokeColor = ColorProvider.StrokeActive();
                    break;
                case StarStyleEnum.Solved:
                    fillColor = ColorProvider.CustomGreen();
                    strokeColor = ColorProvider.StrokeActive();
                    break;
                case StarStyleEnum.Inactive:
                    fillColor = ColorProvider.CustomBlack(); ;
                    strokeColor = ColorProvider.StrokeInactive();
                    strokeThickness = 2;
                    break;
            }
            star.Fill = new SolidColorBrush(fillColor);
            star.Stroke = new SolidColorBrush(strokeColor);
            star.StrokeThickness = strokeThickness;
        }

        private void DeactivateAllStars()
        {
            for (int n = 1; n <= 10; n++)
            {
                SetStarStyle(n, StarStyleEnum.Inactive);
            }
        }

        private void StopLevel()
        {
            _timer.Stop();
            MessageBox.Show(AppResources.TimeUpMsg);
            CheckHighScore();
            _currentStar = 1;
            _currentLevelIndex = 1;
            AppContext.Instance.CurrentProgress.Value = AppContext.LEVELTIME;
        }

        private void OnItemSelected(TextBlock textBlock, Ellipse ellipse)
        {
            bool itemSelected = false;
            int selectedNumber = int.Parse(textBlock.Text);
            bool setStyle = true;

            if (_appContext.SelectedItems.Contains(textBlock))
            {
                itemSelected = false;
                _appContext.SelectedItems.Remove(textBlock);
                _currentSum = _currentSum - selectedNumber;
            }
            else
            {
                itemSelected = true;
                _appContext.SelectedItems.Add(textBlock);
                _currentSum = _currentSum + selectedNumber;
            }


            setStyle = true;
            if (setStyle)
            {
                SetItemStyle(textBlock, itemSelected);
            }
            CheckResult(textBlock);
            textCurrentSum.Text = AppResources.SumText +" "+ _currentSum.ToString();

        }


        private void CheckResult(TextBlock textBlock)
        {
            if (_currentSum == int.Parse(ResultTextBlock.Text))
            {

                double value = this.TimeProgress.Value + _currentLevel.BonusTime;
                StopAllEffects();
                SetProgressBarColor();
                if (value > AppContext.LEVELTIME)
                {
                    value = AppContext.LEVELTIME;
                }
                SetProgresBarValue(value);
                SetStarStyle(_currentStar, StarStyleEnum.Solved);
                if (_currentStar == 10)
                {
                    PlaySound(SOUND_LEVELCOMPLETED);

                    _currentLevelIndex++;
                    DeactivateAllStars();
                    _currentStar = 1;
                    AppContext.Instance.CurrentProgress.Value = AppContext.LEVELTIME;
                    if (_currentLevelIndex <= _levels.Count)
                    {
                        InitLevel();
                    }
                    else
                    {
                        CheckHighScore();
                        EndGame();
                    }
                }
                else
                {
                    _currentStar++;
                    PlaySound(SOUND_CORRECT);
                }
                DeselectAll();
                GenerateTask();
            }
            else if (System.Math.Abs(_currentSum) > System.Math.Abs(int.Parse(ResultTextBlock.Text)))
            {

            }
        }

        private void CheckHighScore()
        {
            _score = new HighScore(_currentLevelIndex, _currentStar - 1,AppContext.Instance.LearningMode.Value,AppContext.Instance.ShowSum.Value);
            if (IsNewHighScore(_score) && _score.TotalScore != 0 && AppContext.Instance.StartLevel.Value==1)
            {
                SaveHighScore();
            }
            else
            {
                SetupLevel();
            }
        }

        private void SaveHighScore()
        {
            InputPrompt input = new InputPrompt
            {
                Title = AppResources.GratsMsg,
                Message = AppResources.PlayerNameTitle

            };
            //input.Value = AppContext.Instance.LastPlayerName.Value;
            input.InputScope = new InputScope { Names = { new InputScopeName() { NameValue = InputScopeNameValue.AlphanumericFullWidth } } };
            input.Show();
            input.Completed += new EventHandler<PopUpEventArgs<string, PopUpResult>>(input_Completed);
        }

        void input_Completed(object sender, PopUpEventArgs<string, PopUpResult> e)
        {
            _score.Ime = e.Result;
            AppContext.Instance.LastPlayerName.Value = _score.Ime;
            AppContext.Instance.AddHighScore(_score);
            MessagePrompt messagePrompt = new MessagePrompt
            {
                Title = "",
                Body = new TextBlock { Text = AppResources.NewGameQuestion,TextWrapping=TextWrapping.Wrap},
                IsCancelVisible=true
            };
            
            messagePrompt.Completed +=new EventHandler<PopUpEventArgs<string,PopUpResult>>(messagePrompt_Completed);
            messagePrompt.Show();
            //SetupLevel();
        }

        void messagePrompt_Completed(object sender, PopUpEventArgs<string, PopUpResult> e)
        {
            if (e.PopUpResult ==PopUpResult.Ok)
            {
                SetupLevel();                
            }
            else
            {
                NavigationService.Navigate(new Uri("/Menu.xaml", UriKind.RelativeOrAbsolute));
            }
            
        }

        private bool IsNewHighScore(HighScore score)
        {
            bool retValue = AppContext.Instance.IsNewHighScore(score);

            return retValue;

        }

        private TextBlock GetTextBlockByEllipse(Ellipse ellipse)
        {

            TextBlock result = _appContext.TextControls[_appContext.EllipseControls.IndexOf(ellipse)];
            return result;
        }

        private Ellipse GetEllipseByTextBlock(TextBlock textBlock)
        {
            Ellipse result = _appContext.EllipseControls[_appContext.TextControls.IndexOf(textBlock)];
            return result;
        }

        private void SetItemStyle(TextBlock textBlock, bool selected)
        {
            Ellipse shape = null;
            switch (textBlock.Name)
            {
                case "LeftTextBlock":
                    shape = this.LeftShape;
                    break;
                case "RightTextBlock":
                    shape = this.RightShape;
                    break;
                case "TopTextBlock":
                    shape = this.TopShape;
                    break;
                case "BottomTextBlock":
                    shape = this.BottomShape;
                    break;
            }

            SolidColorBrush mySolidColorBrush = new SolidColorBrush();
            int strokeThickness = 5;
            if (selected)
            {
                mySolidColorBrush.Color = ColorProvider.CustomGreen();
                strokeThickness = 5;
            }
            else
            {
                mySolidColorBrush.Color = Color.FromArgb(255, 82, 152, 183);
                strokeThickness = 3;
            }
            shape.Fill = mySolidColorBrush;
            shape.StrokeThickness = strokeThickness;
        }

        protected override void OnNavigatedFrom(System.Windows.Navigation.NavigationEventArgs e)
        {
            _timer.Stop();
            AppContext.Instance.CurrentLevelIndex.Value = _currentLevelIndex;
            AppContext.Instance.CurrentStar.Value = _currentStar;
            AppContext.Instance.CurrentProgress.Value = this.TimeProgress.Value;
            base.OnNavigatedFrom(e);
        }

        protected override void OnNavigatedTo(System.Windows.Navigation.NavigationEventArgs e)
        {
            base.OnNavigatedTo(e);
            LoadSettings();
        }

        private void LoadSettings()
        {

            textCurrentSum.Visibility = (bool)AppContext.Instance.ShowSum.Value ? Visibility.Visible : Visibility.Collapsed;
            bool.TryParse(this.NavigationContext.QueryString["NewGame"], out _newGame);
            if (!_newGame)
            {
                _currentLevelIndex = AppContext.Instance.CurrentLevelIndex.Value;
                _currentStar = AppContext.Instance.CurrentStar.Value;
            }
            else
            {
                AppContext.Instance.CurrentProgress.Value = AppContext.LEVELTIME;
                _currentLevelIndex = AppContext.Instance.StartLevel.Value;
            }
            _hiscore = AppContext.Instance.GetLastHighScore();

            SetupLevel();
            for (int n = 1; n <= _currentStar - 1; n++)
            {
                SetStarStyle(n, StarStyleEnum.Solved);
            }
            SetStarStyle(_currentStar, StarStyleEnum.Active);
        }

        private void PlaySound(string soundFile)
        {


            if ((bool)AppContext.Instance.Sound.Value)
            {
                SoundEffect sound;
                // Load the sound file
                StreamResourceInfo info = Application.GetResourceStream(new Uri("Resources/Sounds/" + soundFile, UriKind.Relative));
                // Create an XNA sound effect from the stream
                sound = SoundEffect.FromStream(info.Stream);
                //// Required for XNA sound effects to work
                Microsoft.Xna.Framework.FrameworkDispatcher.Update();
                sound.Play();
            }
            else if ((bool)AppContext.Instance.Vibrate.Value)
            {
                VibrateController.Default.Start(new TimeSpan(0, 0, 2));
            }
        }
        private void EndGame()
        {
            StopLevel();
            NavigationService.Navigate(new Uri("/Menu.xaml", UriKind.RelativeOrAbsolute));

        }
    }
}




