# JPPickerView
用来居中展示文字的PickerView

#####第一步：初始化一个PickerView，让PickerView在自定义的容器中按照我们想要的frame填充。
* 创建一个UIView的子类JPPickerView，在该类的构造方法中传入一个要在pickerView中展示的数组arr。
      -(instancetype)initWithArr:(NSArray<NSString *> *)arr{
          if (self = [super init]) {
              self.arr = arr;
              // 初始化UIPickerView
              [self setUp];
            }
            return self;
        }
* 同时在该构造方法中初始化一个UIPickerView。如果你要自定义PickerView的frame，下面这四行代码你直接拷过去就可以了，强调一下，只能这么写。

      -(void)setUp{
        // **********************************************************************************************
        // 这四行代码至关重要,意思是,在当前View的左上角远点创建一个pickView, 让pickView的左右上下自由伸缩
        // 如果不这么设置,你下面设置的frame就没有效果,不信自己注掉试试看
        UIPickerView *pickView = [[UIPickerView alloc]initWithFrame:CGRectZero];
        pickView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        pickView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        pickView.showsSelectionIndicator = YES;
        // **********************************************************************************************
    
        pickView.dataSource = self;
        pickView.delegate = self;
        self.pickView = pickView;
        pickView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:pickView];
      }

#####第二步：让要显示的文字居中
* 这里使用UILabel来展示要显示的文字，你可以利用UILabel的textAlignment属性来设置文字的对齐模式。同时，这样还能应付那些，比如说，女性用的APP里要将文字定义为粉色，等这样的特殊要求，此时你使用UILabel的attributedText属性就可以实现这个功能。你如果想要自定义字体样式，可以参见[我以前的文章](http://www.jianshu.com/p/69ef0ce3c41f)。

      -(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
        // 这里用label来展示要显示的文字, 然后可以用label的textAlignment来设置文字的对齐模式
        UILabel *myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 35)];
        myView.font = [UIFont systemFontOfSize:18];
        myView.backgroundColor = [UIColor clearColor];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = self.arr[row];
        return myView;
      }
