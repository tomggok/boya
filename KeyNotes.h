//
//  KeyNotes.h
//  Rencountre
//
//  Created by apple on 12-11-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//============================================================================
#pragma mark- 知识点-前台语法相关

#pragma mark-UITabBarItem里的image大小
    //{
    //     在Objective‐C中，所有实例变量默认都是私有的，所有实例方法默认都是公有的,@property和@synthesize过的实例变量其实就是给这个实例变量声明和定义了get和set实例方法
    //    
    //    （UITabBarItem里的image大小默认30*30且忽略不透明值）  需要2倍图以适合ip4的高分辨率,图片名字加@2x
    //}

#pragma mark-打印小数点后边的n位
    //{
    //    要打印小数点后边的n位，就@"%.nf"，n=0时,小数点后边0位，即没有小数点和后边的小数；（ float f=0.123456789;
    //    NSLog(@"%.0f",f); 0
    //    NSLog(@"%.1f",f); 0.1
    //    NSLog(@"%.2f",f)；0.12  ）  
    //}

#pragma mark-UITabBarController
    //{
    //  UITabBarController:
    //    和UINavigationController类似，UITabBarController也可以用来控制多个页面导航，用户可以在多个视图控制器之间移动，并可以定制屏幕底部的选项卡栏。借助屏幕底部的选项卡栏，UITabBarController不必像UINavigationController那样以栈的方式推入和推出视 图，而是组建一系列的控制器（他们各自可以是 UIViewController，UINavigationController，UITableViewController或任何其他种类的视图控 制器），并将它们添加到选项卡栏，使每个选项卡对应一个视图控制器
    //}

#pragma mark-const的作用
    //{
    //    const int a;
    //    int const a;
    //    const int *a;
    //    int * const a;
    //    int const * a const;
    //    
    //    前两个的作用是一样，a是一个常整型数。第三个意味着a是一个指向常整型数的指针（也就是，整型数是不可修改的，但指针可以）。第四个意思a是一个指向整型数的常指针（也就是说，指针指向的整型数是可以修改的，但指针是不可修改的）。最后一个意味着a是一个指向常整型数的常指针（也就是说，指针指向的整型数是不可修改的，同时指针也是不可修改的）。
    //    
    //    结论：
    //    •; 关键字const的作用是为给读你代码的人传达非常有用的信息，实际上，声明一个参数为常量是为了告诉了用户这个参数的应用目的。如果
    //    你曾花很多时间清理其它人留下的垃圾，你就会很快学会感谢这点多余的信息。（当然，懂得用const的程序员很少会留下的垃圾让别人来清
    //    理的。）
    //    •; 通过给优化器一些附加的信息，使用关键字const也许能产生更紧凑的代码。
    //    •; 合理地使用关键字const可以使编译器很自然地保护那些不希望被改变的参数，防止其被无意的代码修改。简而言之，这样可以减少bug的出现。
    //    
    //    （1）欲阻止一个变量被改变，可以使用 const 关键字。在定义该 const 变量时，通常需要对它进行初
    //    始化，因为以后就没有机会再去改变它了；
    //    （2）对指针来说，可以指定指针本身为 const，也可以指定指针所指的数据为 const，或二者同时指
    //    定为 const；
    //    （3）在一个函数声明中，const 可以修饰形参，表明它是一个输入参数，在函数内部不能改变其值；
    //    （4）对于类的成员函数，若指定其为 const 类型，则表明其是一个常函数，不能修改类的成员变量；
    //    （5）对于类的成员函数，有时候必须指定其返回值为 const 类型，以使得其返回值不为“左值”。
    //}

#pragma mark-volatile的作用
    //{
    //    一个定义为volatile的变量是说这变量可能会被意想不到地改变，这样，编译器就不会去假设这个变量的值了。精确地说就是，优化器在用到
    //    这个变量时必须每次都小心地重新读取这个变量的值，而不是使用保存在寄存器里的备份。下面是volatile变量的几个例子：
    //    • 并行设备的硬件寄存器（如：状态寄存器）
    //    • 一个中断服务子程序中会访问到的非自动变量(Non-automatic variables)
    //    • 多线程应用中被几个任务共享的变量
    //    
    //    • 一个参数既可以是const还可以是volatile吗？解释为什么。
    //    • 一个指针可以是volatile 吗？解释为什么。
    //    
    //    下面是答案：
    //    • 是的。一个例子是只读的状态寄存器。它是volatile因为它可能被意想不到地改变。它是const因为程序不应该试图去修改它。
    //    • 是的。尽管这并不很常见。一个例子是当一个中服务子程序修该一个指向一个buffer的指针时
    //}

#pragma mark-static的作用
    //{ 简单阐述static 关键字的作用：
    //    （1）函数体内 static 变量的作用范围为该函数体，不同于 auto 变量，该变量的内存只被分配一次，
    //    因此其值在下次调用时仍维持上次的值；
    //    （2）在模块内的 static 全局变量可以被模块内所用函数访问，但不能被模块外其它函数访问；
    //    （3）在模块内的 static 函数只可被这一模块内的其它函数调用，这个函数的使用范围被限制在声明
    //    它的模块内；
    //    （4）在类中的 static 成员变量属于整个类所拥有，对类的所有对象只有一份拷贝；
    //    （5）在类中的 static 成员函数属于整个类所拥有，这个函数不接收 this 指针，因而只能访问类的static 成员变量。
    //}

#pragma mark-#import跟#include的区别,@class呢？
    //{ #import跟#include的区别,@class呢？
    //    @class一般用于头文件中需要声明该类的某个实例变量的时候用到，在m文件中还是需要使用#import
    //    而#import比起#include的好处就是不会引起重复包含
    //  #import 确定一个文件只能被导入一次，这使你在递归包含中不会出现问题。导入 Objective-C 头文件的时候使用 #import，包含 C/C++ 头文件时使用 #include;#import 被当成 #include 指令的改良版本来使用,这点比C++强
    //}

#pragma mark-线程与进程的区别和联系
    //{ 线程与进程的区别和联系？
    //    进程和线程都是由操作系统所体会的程序运行的基本单元，系统利用该基本单元实现系统对应用的并发性。
    //    进程和线程的主要差别在于它们是不同的操作系统资源管理方式。进程有独立的地址空间，一个进程崩溃后，在保护模式下不会对其它进程产生影响，而线程只是一个进程中的不同执行路径。线程有自己的堆栈和局部变量，但线程之间没有单独的地址空间，一个线程死掉就等于整个进程死掉，所以多进程的程序要比多线程的程序健壮，但在进程切换时，耗费资源较大，效率要差一些。但对于一些要求同时进行并且又要共享某些变量的并发操作，只能用线程，不能用进程。
    //}

#pragma mark-堆和栈的区别
    //{    简单阐述堆和栈的区别：
    //    管理方式：对于栈来讲，是由编译器自动管理，无需我们手工控制；对于堆来说，释放工作由程序员控制，容易产生memory leak。
    //    申请大小：
    //    栈：在Windows下,栈是向低地址扩展的数据结构，是一块连续的内存的区域。这句话的意思是栈顶的地址和栈的最大容量是系统预先规定好的，在WINDOWS下，栈的大小是2M（也有的说是1M，总之是一个编译时就确定的常数），如果申请的空间超过栈的剩余空间时，将提示overflow。因此，能从栈获得的空间较小。
    //    堆：堆是向高地址扩展的数据结构，是不连续的内存区域。这是由于系统是用链表来存储的空闲内存地址的，自然是不连续的，而链表的遍历方向是由低地址向高地址。堆的大小受限于计算机系统中有效的虚拟内存。由此可见，堆获得的空间比较灵活，也比较大。
    //    碎片问题：对于堆来讲，频繁的new/delete势必会造成内存空间的不连续，从而造成大量的碎片，使程序效率降低。对于栈来讲，则不会存在这个问题，因为栈是先进后出的队列，他们是如此的一一对应，以至于永远都不可能有一个内存块从栈中间弹出
    //    分配方式：堆都是动态分配的，没有静态分配的堆。栈有2种分配方式：静态分配和动态分配。静态分配是编译器完成的，比如局部变量的分配。动态分配由alloca函数进行分配，但是栈的动态分配和堆是不同的，他的动态分配是由编译器进行释放，无需我们手工实现。
    //    分配效率：栈是机器系统提供的数据结构，计算机会在底层对栈提供支持：分配专门的寄存器存放栈的地址，压栈出栈都有专门的指令执行，这就决定了栈的效率比较高。堆则是C/C++函数库提供的，它的机制是很复杂的。
    //}

#pragma mark-Objective-C内存管理
    //{    Objective-C内存管理：
    //    1.当你使用new,alloc和copy方法创建一个对象时,该对象的保留计数器值为1.当你不再使用该对象时,你要负责向该对象发送一条release或autorelease消息.这样,该对象将在使用寿命结束时被销毁.
    //    2.当你通过任何其他方法获得一个对象时,则假设该对象的保留计数器值为1,而且已经被设置为自动释放,你不需要执行任何操作来确保该对象被清理.如果你打算在一段时间内拥有该对象,则需要保留它并确保在操作完成时释放它.
    //    3.如果你保留了某个对象,你需要(最终)释放或自动释放该对象.必须保持retain方法和release方法的使用次数相等.
    //}

#pragma mark-定义属性时，什么情况使用copy，assign，和retain,readwrite，readonly,nonatomic
    //{    http://www.2cto.com/kf/201205/133943.html

    //    assign用于简单数据类型，如NSInteger,double,bool,和C数据类型（int, float, double, char,等
    //    retain是指针拷贝，copy是内容拷贝。在拷贝之前，都会释放旧的对象。会使计数器加一,将旧对象的值赋予输入对象，再提高输入对象的索引计数为1, 用于对其他NSObject和其子类
    //    copy： 建立一个索引计数为1的对象，然后释放旧对象,  使用copy： 对NSString    
    //    另外：atomic和nonatomic用来决定编译器生成的getter和setter是否为原子操作。在多线程环境下，原子操作是必要的，否则有可能引起错误的结果。
    //    加了atomic，setter函数会变成下面这样：
    //    if (property != newValue) {
    //        [property release];
    //        property = [newValue retain];
    //    }

    //@property是 一个属性访问声明，扩号内支持以下几个属性：
    //1，getter=getterName，setter=setterName，设置setter与 getter的方法名
    //2，readwrite，设置可供访问级别
    //2，assign，setter方法直接赋值，不进行 任何retain操作，为了解决原类型与环循引用问题
    //3，retain，setter方法对参数进行release旧值再retain新值，所有 实现都是这个顺序(CC上有相关资料)
    //4，copy，setter方法进行Copy操作，与retain处理流程一样，先旧值release，再 Copy出新的对象，retainCount为1。这是为了减少对上下文的依赖而引入的机制。
    //5，nonatomic，非原子性访问，不加同步， 多线程并发访问会提高性能。注意，如果不加此属性，则默认是两个访问方法都为原子型事务访问。锁被加到所属对象实例级(我是这么理解的...)。
    //6.readonly表示这个属性是只读的，就是只生成getter方法，不会生成setter方法．

//{
//    @property(nonatomic, retain) UITextField *userName编译时自动生成的代码
//    - (UITextField *) userName {
//    return userName;
//}
//
//- (void) setUserName:(UITextField *)userName_ {
//    [userName release];
//    userName = [userName_ retain];
//}
//
//
//@property(retain) UITextField *userName自动生成的代码
//
//- (UITextField *) userName {
//UITextField *retval = nil;
//@synchronized(self) {
//retval = [[userName retain] autorelease];
//}
//return retval;
//}
//
//- (void) setUserName:(UITextField *)userName_ {
//    @synchronized(self) {
//        [userName release];
//        userName = [userName_ retain];
//    }
//}
//}

    //}

#pragma mark-类别的作用？继承和类别在实现中有何区别？
    //{    类别的作用？继承和类别在实现中有何区别？ What is advantage of categories? What is difference between implementing a category and inheritance?
    //    答案：   可以在不获悉，不改变原来代码的情况下往里面添加新的方法，只能添加，不能删除修改。
    //    并且如果类别和原来类中的方法产生名称冲突，则类别将覆盖原来的方法，因为类别具有更高的优先级。
    //    类别主要有3个作用：
    //    (1)将类的实现分散到多个不同文件或多个不同框架中。
    //    (2)创建对私有方法的前向引用。
    //    (3)向对象添加非正式协议。
    //    继承可以增加，修改或者删除方法，并且可以增加属性。
    //类别=动态(不继承数据也不须实现方法的)子类
    //类别里不能放成员数据,只能放新添加的方法
//  类别的.h和.m只要在项目里,不需要import就能用
    //}

#pragma mark-类别和类扩展的区别
//http://iosnote.diandian.com/post/2012-04-28/19695807
//http://blog.163.com/wangy_0223/blog/static/4501466120123181211744/

//    答案：category和extensions的不同在于 后者可以添加属性。另外后者添加的方法是必须要实现的。
//    extensions可以认为是一个私有的Category。

//http://blog.csdn.net/jjunjoe/article/details/8737874
//形式上来看，extension是匿名的category。
//extension里声明的方法需要在mainimplementation中实现，category不强制要求。

//类别里也可以声明实例变量,但必须在类别的.h里用@property把变量的属性声明好,而且在类别的.m里用 @dynamic 告诉编译器不用在编译时创建变量的set和get方法的实现代码,由我们手动边写,在set和get方法里用runtime里的objc_setAssociatedObject和objc_getAssociatedObject方法操作变量,具体看 "类似path的下拉tbv后其顶部图片也会拉伸2"项目里的UITableView+ZGParallelView.m类
//}

#pragma mark-\r\n
    //{
    //    "\r\n"确保在任何情况下都换行,单独用"\r"或"\n"时也是换行
    //    “\t”是向右缩进3个英文字符
    //}

#pragma mark-.h文件里为何不能定义static变量
    //{
    //    Obj-c没有静态成员变量这一说,不能类名+点获取静态变量(oc不支持重载运算符,所以类名.运算符没重载),可以且必须在.h和.m里声明和定义一个+的函数返回此静态变量,再通过类名调这个类函数;  全局变量和静态变量只有唯一区别就是静态变量只有一份内存;
    //
    //}

#pragma mark-应用程序图标不加高光
    //{
    //   在plist里加一个"Icon already includes gloss effects"键,值设成YES
    //}

#pragma mark-oc中的协议protocol和java中的接口概念有何不同
    //    答案：OC中的代理有2层含义，官方定义为 formal和informal protocol。前者和Java接口一样。
    //    informal protocol中的方法属于设计模式考虑范畴，不是必须实现的，但是如果有实现，就会改变类的属性。
    //    其实关于正式协议，类别和非正式协议我很早前学习的时候大致看过，也写在了学习教程里
    //    “非正式协议概念其实就是类别的另一种表达方式“这里有一些你可能希望实现的方法，你可以使用他们更好的完成工作”
    //    这个意思是，这些是可选的。比如我门要一个更好的方法，我们就会申明一个这样的类别去实现。然后你在后期可以直接使用这些更好的方法。
    //    这么看，总觉得类别这玩意儿有点像协议的可选协议。"
    //    现在来看，其实protocal已经开始对两者都统一和规范起来操作，因为资料中说“非正式协议使用interface修饰“，
    //    现在我们看到协议中两个修饰词：“必须实现(@requied)”和“可选实现(@optional)”。

//protocol里貌似不声明变量,只声明方法,类似接口
    //}

#pragma mark-代理的作用
    //{   代理的作用？ What is purpose of delegates?     
    //    答案：代理的目的是改变或传递控制链。允许一个类在某些特定时刻通知到其他类，而不需要获取到那些类的指针。可以减少框架复杂度。
    //    另外一点，代理可以理解为java中的回调监听机制的一种类似。
    //}

#pragma mark-代理delegate的属性为何是assign
//{ http://longtimenoc.com/archives/objective-c-delegate%E7%9A%84%E9%82%A3%E7%82%B9%E4%BA%8B%E5%84%BF
//    循环引用
//    所有的引用计数系统，都存在循环应用的问题。例如下面的引用关系：
//    •    对象a创建并引用到了对象b.
//    •    对象b创建并引用到了对象c.
//    •    对象c创建并引用到了对象b.
//    这时候b和c的引用计数分别是2和1。当a不再使用b，调用release释放对b的所有权，因为c还引用了b，所以b的引用计数为1，b不会被释放。b不释放，c的引用计数就是1，c也不会被释放。从此，b和c永远留在内存中。
//    这 种情况，必须打断循环引用，通过其他规则来维护引用关系。比如，我们常见的delegate往往是assign方式的属性而不是retain方式 的属性，赋值不会增加引用计数，就是为了防止delegation两端产生不必要的循环引用。如果一个UITableViewController 对象a通过retain获取了UITableView对象b的所有权，这个UITableView对象b的delegate又是a， 如果这个delegate是retain方式的，那基本上就没有机会释放这两个对象了。自己在设计使用delegate模式时，也要注意这点。
//    因为循环引用而产生的内存泄露也是Instrument无法发现的，所以要特别小心
//}

#pragma mark-C里char的长度
//{
//    一个英文字母用[NSStrng UTF8String]转化成的const char*的长度是1
//    一个中文用[NSStrng UTF8String]转化成的const char*的长度是3(一个中文=2个英文+一个"\0"结尾符)
//}

#pragma mark-oc中可修改和不可以修改类型
    //{    What are mutable and immutable types in Objective C?    oc中可修改和不可以修改类型。
    //    答案：可修改不可修改的集合类。这个我个人简单理解就是可动态添加修改和不可动态添加修改一样。
    //    比如NSArray和NSMutableArray。前者在初始化后的内存控件就是固定不可变的，后者可以添加等，可以动态申请新的内存空间。
    //}

#pragma mark-oc是动态运行时语言是什么意思
    //{ When we call objective c is runtime language what does it mean?  我们说的oc是动态运行时语言是什么意思？
    //    答案：多态。 主要是将数据类型的确定由编译时，推迟到了运行时。
    //    这个问题其实浅涉及到两个概念，运行时和多态。
    //    简单来说，运行时机制使我们直到运行时才去决定一个对象的类别，以及调用该类别对象指定方法。
    //    多态：不同对象以自己的方式响应相同的消息的能力叫做多态。意思就是假设生物类（life）都用有一个相同的方法-eat;
    //    那人类属于生物，猪也属于生物，都继承了life后，实现各自的eat，但是调用是我们只需调用各自的eat方法。
    //    也就是不同的对象以自己的方式响应了相同的消息（响应了eat这个选择器）。
    //    因此也可以说，运行时机制是多态的基础？~~~
    //}

#pragma mark-通知和协议的不同之处
    //{ what is difference between NSNotification and protocol?
    //    通知和协议的不同之处？
    //    答案：协议有控制链(has-a)的关系，通知没有。
    //    简单来说，通知的话，它可以一对多，一条消息可以发送给多个消息接受者。
    //    代理按我们的理解，到不是直接说不能一对多，比如我们知道的明星经济代理人，很多时候一个经济人负责好几个明星的事务。
    //    只是对于不同明星间，代理的事物对象都是不一样的，一一对应，不可能说明天要处理A明星要一个发布会，代理人发出处理发布会的消息后，别成B的
    //    发布会了。但是通知就不一样，他只关心发出通知，而不关心多少接收到感兴趣要处理。
    //    因此控制链（has-a从英语单词大致可以看出，单一拥有和可控制的对应关系。
    //  协议=动态(可选实现函数的)接口；
    //}

#pragma mark-NSLog类型
    //{
    //nslog: 
    //    %u: 打印无符号整形
    //    %x: 打印2进制整数
    //    %o: 打印8进制整数
    //    %p: 打印对象首地址指针
    //    %s: C字符串
    //    %c: 字符
    //    %C: unichar
    //    %lld: 64位长整数
    //    %lu:无符号64位长整数(Unsigned long)
    //    %llu: 无符号64位长整数(Unsigned long long)    
    //}

#pragma mark-什么是推送消息
    //{    What is push notification?
    //    什么是推送消息？
    //    简单点就是客户端获取资源的一种手段。
    //    普通情况下，都是客户端主动的pull。
    //    推送则是服务器端主动push给苹果,苹果再push给客户端。
    //}

#pragma mark-关于多态性   Polymorphism？
    //{ 
    //    答案：多态，子类指针可以赋值给父类。
    //    这个题目其实可以出到一切面向对象语言中，
    //    因此关于多态，继承和封装基本最好都有个自我意识的理解，也并非一定要把书上资料上写的能背出来。
    //    最重要的是转化成自我理解。
    //}

#pragma mark-响应链   What is responder chain? 
    //{
    //    答案： 事件响应链。包括点击事件，画面刷新事件等。在视图栈内从上至下，或者从下之上传播。
    //    可以说点事件的分发，传递以及处理。具体可以去看下touch事件这块。因为问的太抽象化了
    //    严重怀疑题目出到越后面就越笼统
    //}

#pragma mark-frame和bounds有什么不同  Difference between frame and bounds？
    //{
    //    答案:frame指的是：该view在父view坐标系统中的位置和大小。（参照点是父亲的坐标系统）
    //    bounds指的是：该view在本身坐标系统中 的位置和大小。（参照点是本身坐标系统）
    //}

#pragma mark-方法和选择器有何不同  Difference between method and selector？
    //{
    //    答案：selector是一个方法的名字，method是一个组合体，包含了名字和实现.
    //    详情可以看apple文档。
    //}

#pragma mark-OC的垃圾回收机制   Is there any garbage collection mechanism in Objective C? 
    //{
    //    答案： OC2.0有Garbage collection，但是iOS平台不提供。
    //    一般我们了解的objective-c对于内存管理都是手动操作的，但是也有自动释放池。
    //    但是差了大部分资料，貌似不要和arc机制搞混就好了。
    //}

#pragma mark-NSOperation queue? 
    //{
    //    答案：存放NSOperation的集合类。
    //    操作和操作队列，基本可以看成java中的 线程和线程池 的概念。用于处理ios多线程开发的问题。
    //    网上部分资料提到一点是，虽然是queue，但是却并不是带有队列的概念，放入的操作并非是按照严格的先进现出。
    //    这边又有个疑点是，对于队列来说，先进先出的概念是Afunc添加进队列，Bfunc紧跟着也进入队列，Afunc先执行这个是必然的，
    //    但是Bfunc是等Afunc完全操作完以后，B才开始启动并且执行，因此队列的概念理论上有点违背了多线程处理这个概念。
    //    但是转念一向其实可以参考银行的取票和叫号系统。
    //    因此对于A比B先排队取票但是B率先执行完操作，我们亦然可以感性认为这还是一个队列。
    //    但是后来看到一票关于这操作队列话题的文章，其中有一句提到
    //    “因为两个操作提交的时间间隔很近，线程池中的线程，谁先启动是不定的。”
    //    瞬间觉得这个queue名字有点忽悠人了，还不如pool~
    //    综合一点，我们知道他可以比较大的用处在于可以帮助多线程编程就好了。
    //}

#pragma mark-什么是懒汉模式?  What is lazy loading?  
    //{
    //    答案：懒汉模式，只在用到的时候才去初始化。
    //    也可以理解成延时加载。
    //    我觉得最好也最简单的一个列子就是tableView中图片的加载显示了。
    //    一个延时载，避免内存过高，一个异步加载，避免线程堵塞。
    //}

#pragma mark-能否在一个视图控制器中嵌入两个tableview控制器？Can we use two tableview controllers on one viewcontroller?  
    //{
    //    答案：一个视图控制器只提供了一个View视图，理论上一个tableViewController也不能放吧，
    //    只能说可以嵌入一个tableview视图。当然，题目本身也有歧义，如果不是我们定性思维认为的UIViewController，
    //    而是宏观的表示视图控制者，那我们倒是可以把其看成一个视图控制者，它可以控制多个视图控制器，比如TabbarController
    //    那样的感觉。
    //}

#pragma mark-一个tableView是否可以关联两个不同的数据源？你会怎么处理？Can we use one tableview with two different datasources? How you will achieve this?
    //{
    //    答案：首先我们从代码来看，数据源如何关联上的，其实是在数据源关联的代理方法里实现的。
    //    因此我们并不关心如何去关联他，他怎么关联上，方法只是让我返回根据自己的需要去设置如相关的数据源。
    //    因此，我觉得可以设置多个数据源啊，但是有个问题是，你这是想干嘛呢？想让列表如何显示，不同的数据源分区块显示？
    //}

#pragma mark-Object－c的类可以多重继承么？可以实现多个接口么？Category是什么？重写一个类的方式用继承好还是分类好？为什么？
    //{
    //    object-c不能够多继承,那么有没有别的方式来替代呢？有，一种我们称之为伪继承，另一种我们可以通过ios中无处不在的@protocol委托方式来实现;
    //    1.伪继承,在 Merchant.m里有实现

    //    尽管再objtive-C中不提供多继承，但它提供了另外一种解决方案,使对象可以响应在其它类中实现的消息(别的语言中，一般叫方法，两者无差别). 这种解决方案叫做消息转发，它可以使一个类响应另外一个类中实现的消息。
    //    在一般情况下，发送一个无法识别的消息会产生一个运行时的错误，导致应用程序崩溃,但是注意，在崩溃之前，iphone运行时对象为每个对象提供了第二次机会来处理消息。捕捉到一条消息后可以把它重新定向到可以响应该消息的对象。在这个时候，runtime 并没有放弃最后的努力，在没有找到对应的方法的时候，runtime会向对象发送一个forwardInvocation:的消息，并且把原始的消息以及消息的参数打成一个NSInvocation的一个对象里面，作为forwardInvocation:的唯一的参数。 forwardInvocation:本身是在NSObject里面定义的，如果你需要重载这个函数的话，那么任何试图向你的类发送一个没有定义的消息的话，你都可以在forwardInvocation:里面捕捉到，并且把消息送到某一个安全的地方，从而避免了系统报错

    //    这个功能完全通过消息转发来实现，发送消息给一个无法处理该选择器的对象时，这个选择器就会被转发给 forwardInvocation 方法.接收这条消息的对象，用一个NSInvocation的实例保存原始的选择器和被请求的参数.所以，我们可以覆盖 forwardInvocation 方法，并把消息转发给另外一个对象.
    //}

#pragma mark-_bridge，__bridge_transfer和__bridge_retained的区别
    //{
    //    Core Foundation 框架
    //    Core Foundation框架 (CoreFoundation.framework) 是一组C语言接口，它们为iOS应用程序提供基本数据管理和服务功能。下面列举该框架支持进行管理的数据以及可提供的服务：
    //    群体数据类型 (数组、集合等)
    //    程序包
    //    字符串管理
    //    日期和时间管理
    //    原始数据块管理
    //    偏好管理
    //    URL及数据流操作
    //    线程和RunLoop
    //    端口和soket通讯
    //    Core Foundation框架和Foundation框架紧密相关，它们为相同功能提供接口，但Foundation框架提供Objective-C接口。如果您将Foundation对象和Core Foundation类型掺杂使用，则可利用两个框架之间的 “toll-free bridging”。所谓的Toll-free bridging是说您可以在某个框架的方法或函数同时使用Core Foundatio和Foundation 框架中的某些类型。很多数据类型支持这一特性，其中包括群体和字符串数据类型。每个框架的类和类型描述都会对某个对象是否为 toll-free bridged，应和什么对象桥接进行说明。
    //    如需进一步信息，请阅读Core Foundation 框架参考。
    //    
    //    自 Xcode4.2 开始导入ARC机制后，为了支持对象间的转型，Apple又增加了许多转型用的关键字。这一讲我们就来了解其用法，以及产生的理由。
    //    引子
    //    我们先来看一下ARC无效的时候，我们写id类型转void*类型的写法：
    //    id obj = [[NSObject alloc] init];
    //    void *p = obj;
    //    反过来，当把void*对象变回id类型时，只是简单地如下来写，
    //    id obj = p;
    //    [obj release];
    //    但是上面的代码在ARC有效时，就有了下面的错误：
    //error: implicit conversion of an Objective-C pointer
    //    to ’void *’ is disallowed with ARC
    //    void *p = obj;
    //    ^
    //    
    //error: implicit conversion of a non-Objective-C pointer
    //    type ’void *’ to ’id’ is disallowed with ARC
    //    id o = p;
    //    ^
    //    __bridge
    //    为了解决这一问题，我们使用 __bridge 关键字来实现id类型与void*类型的相互转换。看下面的例子。
    //    id obj = [[NSObject alloc] init];
    //    
    //    void *p = (__bridge void *)obj;
    //    
    //    id o = (__bridge id)p;
    //    将Objective-C的对象类型用 __bridge 转换为 void* 类型和使用 __unsafe_unretained 关键字修饰的变量是一样的。被代入对象的所有者需要明确对象生命周期的管理，不要出现异常访问的问题。
    //    除过 __bridge 以外，还有两个 __bridge 相关的类型转换关键字：
    //    __bridge_transfer
    //    __bridge_retained
    //    接下来，我们将看看这两个关键字的区别。
    //    
    //    __bridge_retained
    //    先来看使用 __bridge_retained 关键字的例子程序：
    //    id obj = [[NSObject alloc] init];
    //    
    //    void *p = (__bridge_retained void *)obj;
    //    从名字上我们应该能理解其意义：类型被转换时，其对象的所有权也将被变换后变量所持有。如果不是ARC代码，类似下面的实现：
    //    id obj = [[NSObject alloc] init];
    //    
    //    void *p = obj;
    //    [(id)p retain];
    //    可以用一个实际的例子验证，对象所有权是否被持有。
    //    void *p = 0;
    //    
    //    {
    //    id obj = [[NSObject alloc] init];
    //    p = (__bridge_retained void *)obj;
    //    }
    //    
    //    NSLog(@"class=%@", [(__bridge id)p class]);
    //    出了大括号的范围后，p 仍然指向一个有效的实体。说明他拥有该对象的所有权，该对象没有因为出其定义范围而被销毁。
    //    __bridge_transfer
    //    相反，当想把本来拥有对象所有权的变量，在类型转换后，让其释放原先所有权的时候，需要使用 __bridge_transfer 关键字。文字有点绕口，我们还是来看一段代码吧。
    //    如果ARC无效的时候，我们可能需要写下面的代码。
    //        // p 变量原先持有对象的所有权
    //    id obj = (id)p;
    //    [obj retain];
    //    [(id)p release];
    //    那么ARC有效后，我们可以用下面的代码来替换：
    //        // p 变量原先持有对象的所有权
    //    id obj = (__bridge_transfer id)p;
    //    可以看出来，__bridge_retained 是编译器替我们做了 retain 操作，而 __bridge_transfer 是替我们做了 release1。
    //    Toll-Free bridged
    //    在iOS世界，主要有两种对象：Objective-C 对象和 Core Foundation 对象0。Core Foundation 对象主要是有C语言实现的 Core Foundation Framework 的对象，其中也有对象引用计数的概念，只是不是 Cocoa Framework::Foundation Framework 的 retain/release，而是自身的 CFRetain/CFRelease 接口。
    //    这两种对象间可以互相转换和操作，不使用ARC的时候，单纯的用C原因的类型转换，不需要消耗CPU的资源，所以叫做 Toll-Free bridged。比如 NSArray和CFArrayRef, NSString和CFStringRef，他们虽然属于不同的 Framework，但是具有相同的对象结构，所以可以用标准C的类型转换。
    //    比如不使用ARC时，我们用下面的代码：
    //    NSString *string = [NSString stringWithFormat:...];
    //    CFStringRef cfString = (CFStringRef)string;
    //    同样，Core Foundation类型向Objective-C类型转换时，也是简单地用标准C的类型转换即可。
    //    但是在ARC有效的情况下，将出现类似下面的编译错误：
    //    Cast of Objective-C pointer type ‘NSString *’ to C pointer type ‘CFStringRef’ (aka ‘const struct __CFString *’) requires a bridged cast
    //    Use __bridge to convert directly (no change in ownership)
    //    Use __bridge_retained to make an ARC object available as a +1 ‘CFStringRef’ (aka ‘const struct __CFString *’)
    //    错误中已经提示了我们需要怎样做：用 __bridge 或者 __bridge_retained 来转型，其差别就是变更对象的所有权。
    //    正因为Objective-C是ARC管理的对象，而Core Foundation不是ARC管理的对象，所以才要特意这样转换，这与id类型向void*转换是一个概念。也就是说，当这两种类型（有ARC管理，没有ARC管理）在转换时，需要告诉编译器怎样处理对象的所有权。
    //    上面的例子，使用 __bridge/__bridge_retained 后的代码如下：
    //    NSString *string = [NSString stringWithFormat:...];
    //    CFStringRef cfString = (__bridge CFStringRef)string;
    //    只是单纯地执行了类型转换，没有进行所有权的转移，也就是说，当string对象被释放的时候，cfString也不能被使用了。
    //    NSString *string = [NSString stringWithFormat:...];
    //    CFStringRef cfString = (__bridge_retained CFStringRef)string;
    //    ...
    //    CFRelease(cfString); // 由于Core Foundation的对象不属于ARC的管理范畴，所以需要自己release
    //    使用 __bridge_retained 可以通过转换目标处（cfString）的 retain 处理，来使所有权转移。即使 string 变量被释放，cfString 还是可以使用具体的对象。只是有一点，由于Core Foundation的对象不属于ARC的管理范畴，所以需要自己release。
    //    实际上，Core Foundation 内部，为了实现Core Foundation对象类型与Objective-C对象类型的相互转换，提供了下面的函数。
    //    CFTypeRef  CFBridgingRetain(id  X)  {
    //        return  (__bridge_retained  CFTypeRef)X;
    //    }
    //    
    //    id  CFBridgingRelease(CFTypeRef  X)  {
    //        return  (__bridge_transfer  id)X;
    //    }
    //    所以，可以用 CFBridgingRetain 替代 __bridge_retained 关键字：
    //    NSString *string = [NSString stringWithFormat:...];
    //    CFStringRef cfString = CFBridgingRetain(string);
    //    ...
    //    CFRelease(cfString); // 由于Core Foundation不在ARC管理范围内，所以需要主动release。
    //    __bridge_transfer
    //    所有权被转移的同时，被转换变量将失去对象的所有权。当Core Foundation对象类型向Objective-C对象类型转换的时候，会经常用到 __bridge_transfer 关键字。
    //    CFStringRef cfString = CFStringCreate...();
    //    NSString *string = (__bridge_transfer NSString *)cfString;
    //    
    //        // CFRelease(cfString); 因为已经用 __bridge_transfer 转移了对象的所有权，所以不需要调用 release
    //    同样，我们可以使用 CFBridgingRelease() 来代替 __bridge_transfer 关键字。
    //    CFStringRef cfString = CFStringCreate...();
    //    NSString *string = CFBridgingRelease(cfString);
    //    
    //    总结
    //    由上面的学习我们了解到 ARC 中类型转换的用法，那么我们实际使用中按照怎样的原则或者方法来区分使用呢，下面我总结了几点关键要素。
    //    明确被转换类型是否是 ARC 管理的对象
    //    Core Foundation 对象类型不在 ARC 管理范畴内
    //    Cocoa Framework::Foundation 对象类型（即一般使用到的Objectie-C对象类型）在 ARC 的管理范畴内
    //    如果不在 ARC 管理范畴内的对象，那么要清楚 release 的责任应该是谁
    //    各种对象的生命周期是怎样的
    //    1. 声明 id obj 的时候，其实是缺省的申明了一个 __strong 修饰的变量，所以编译器自动地加入了 retain 的处理，所以说 __bridge_transfer 关键字只为我们做了 release 处理。
    //}


#pragma mark-单例模式 具体见 CustomSingleMode.h
    //{
    //    Foundation和Application Kit框架中的一些类只允许创建单件对象，即这些类在当前进程中的唯一实例。举例来说，NSFileManager和NSWorkspace类在使用时都是基于进程进行单件对象的实例化。当您向这些类请求实例的时候，它们会向您传递单一实例的一个引用，如果该实例还不存在，则首先进行实例的分配和初始化。
    //    单件对象充当控制中心的角色，负责指引或协调类的各种服务。如果您的类在概念上只有一个实例（比如NSWorkspace），就应该产生一个单件实例，而不是多个实例；如果将来某一天可能有多个实例，您可以使用单件实例机制，而不是工厂方法或函数。
    //    
    //    创建单件实例时，您需要在代码中执行下面的工作：
    //    
    //    声明一个单件对象的静态实例，并初始化为nil。
    //    
    //    在该类的类工厂方法（名称类似于“sharedInstance”或“sharedManager”）中生成该类的一个实例，但仅当静态实例为nil的时候。
    //    
    //    重载allocWithZone:方法，确保当用户试图直接（而不是通过类工厂方法）分配或初始化类的实例时，不会分配出另一个对象。
    //    
    //    实现基本协议方法：copyWithZone:、release、retain、retainCount、和autorelease ，以保证单件的状态。
    //}

#pragma mark-obj-c有私有方法么?私有变量呢
    //{
    //    objective-c - 类里面的方法只有两种, 静态方法和实例方法. 这似乎就不是完整的面向对象了,按照OO的原则就是一个对象只暴露有用的东西. 如果没有了私有方法的话, 对于一些小范围的代码重用就不那么顺手了. 在类里面声名一个私有方法,如果在.h里没有定义,但在.m里实现了的方法,也是私有方法,只能在此类里调,在类外和此类的子类里都调不了

    //@interface Controller : NSObject 
    //{ 
    //    NSString *something; 
    //}
    //
    //+ (void)thisIsAStaticMethod;
    //
    //- (void)thisIsAnInstanceMethod;
    //
    //@end

    //@interface Controller (private) 
    //-(void)thisIsAPrivateMethod;
    //@end

    //@private可以用来修饰私有变量
    //    
    //    在Objective‐C中，所有实例变量默认都是私有的，所有实例方法默认都 是公有的
    //}

#pragma mark-extern "C" 的作用
    //{
    //    （1）被 extern "C"限定的函数或变量是 extern 类型的；
    //    
    //    extern 是 C/C++语言中表明函数和全局变量作用范围（可见性）的关键字，该关键字告诉编译器，
    //    其声明的函数和变量可以在本模块或 其它模块中使用。
    //    
    //    （2）被 extern "C"修饰的变量和函数是按照 C 语言方式编译和连接的； 
    //    
    //    extern "C"的惯用法 
    //    
    //    （1）在 C++中引用 C 语言中的函数和变量，在包含 C 语言头文件（假设为 cExample.h）时，需进
    //    行下列处理： 
    //    extern "C"  
    //    {  
    //#include "cExample.h"  
    //    }  
    //    而在 C 语言的头文件中，对其外部函数只能指定为 extern 类型，C 语言中不支持 extern "C"声明，
    //    在.c 文件中包含了 extern "C"时会出现编译语法错误。
    //    
    //    （2）在 C 中引用 C++语言中的函数和变量时，C++的头文件需添加 extern "C"，但是在 C 语言中不
    //    能直接引用声明了 extern "C"的该头文件，应该仅将 C 文件中将 C++中定义的 extern "C"函数声明为
    //    extern 类型。
    //}

#pragma mark-为什么标准头文件都有类似以下#ifndef的结构？
    //{
    //#ifndef __INCvxWorksh  
    //#define __INCvxWorksh  
    //#ifdef __cplusplus  
    //    extern "C" {  
    //#endif  
    //        
    //#ifdef __cplusplus  
    //    }  
    //#endif  
    //#endif  
    //    
    //    显然，头文件中的编译宏

    //#ifndef __INCvxWorksh
    //#define __INCvxWorksh

    //#endif” 

    //的作用是防止该头文件被重复引用
    //}

#pragma mark-MVC模式的理解
    //{
    //MVC设计模式考虑三种对象：模型对象、视图对象、和控制器对象。模型对象代表 特别的知识和专业技能，它们负责保有应用程序的数据和定义操作数据的逻辑。视图对象知道如何显示应用程序的模型数据，而且可能允许用户对其进行编辑。控制 器对象是应用程序的视图对象和模型对象之间的协调者。
    //}

#pragma mark-c和obj-c如何混用
    //{
    //    1）obj-c的编译器处理后缀为m的文件时，可以识别obj-c和c的代码， 处理mm文件可以识别obj-c,c,c++代码，但cpp文件必须只能用c/c++代码，而且cpp文件include的头文件中，也不能出现obj- c的代码，因为cpp只是cpp
    //    2) 在mm文件中混用cpp直接使用即可，所以obj-c混cpp不是问题
    //    3）在cpp中混用obj- c其实就是使用obj-c编写的模块是我们想要的。
    //    如果模块以类实现，那么要按照cpp class的标准写类的定义，头文件中不能出现obj-c的东西，包括#import cocoa的。实现文件中，即类的实现代码中可以使用obj-c的东西，可以import,只是后缀是mm。
    //    如果模块以函数实现，那么头文件要按 c的格式声明函数，实现文件中，c++函数内部可以用obj-c，但后缀还是mm或m。
    //    
    //    总结：只要cpp文件和cpp include的文件中不包含obj-c的东西就可以用了，cpp混用obj-c的关键是使用接口，而不能直接使用实现代码，实际上cpp混用的是 obj-c编译后的o文件，这个东西其实是无差别的，所以可以用。obj-c的编译器支持cpp.
    //}

#pragma mark-自动释放池是什么,如何工作
    //{
    //    当您向一个对象发送一个autorelease消息时，Cocoa就会将该对象的一个引用放入到最新的自动释放池。它仍然是个正当的对象，因此自动释放池定义的作用域内的其它对象可以向它发送消息。当程序执行到作用域结束的位置 时，自动释放池就会被释放，池中的所有对象也就被释放。
    //    
    //    1.  ojc-c 是通过一种"referring counting"(引用计数)的方式来管理内存的, 对象在开始分配内存(alloc)的时候引用计数为一,以后每当碰到有copy,retain的时候引用计数都会加一, 每当碰到release和autorelease的时候引用计数就会减一,如果此对象的计数变为了0, 就会被系统销毁.
    //    2. NSAutoreleasePool 就是用来做引用计数的管理工作的,这个东西一般不用你管的.
    //    3. autorelease和release没什么区别,只是引用计数减一的时机不同而已,autorelease会在对象的使用真正结束的时候才做引用计数 减一.
    //autorelease函数，通过函数名你应该可以知道这个是帮你自动release的。但是需要注意的是这个函数只会自动帮你release1次，你如果在中间使用了retain之类的，所以还请手动release。同时这个有一个致命的缺点，你想用autorelease在class A中创建对象然后传递给class B使用的话这是非常危险的，autorelease是基于系统自带的自动释放池来进行内存管理，系统会每隔一段时间去检测施放池中的对象，并且释放不在使用的对象。当你传递给B的时候，还没来得及使用，被自动释放掉了，那么你的程序又会crash。所以 autorelease通常都是在局部对象中使用
    //}

#pragma mark-obj-c的优缺点
    //{
    //    objc优点：
    //    1) Cateogies 类别
    //    2) Posing 推送
    //    3) 动态识别
    //    4) 指标计算 
    //    5）弹性讯息传递
    //    6) 不是一个过度复杂的 C 衍生语言
    //    7) Objective-C 与 C++ 可混合编程
    //    缺点: 
    //    1) 不支援命名空間 
    //    2)  不支持运算符重载
    //    3） 不支持多重继承
    //    4） 使用动态运行时类型，所有的方法都是函数调用，所以很多编译时优化方法都用不到。（如内联函数等），性能低劣。
    //}

#pragma mark-类工厂方法是什么
    //{
    //    类工厂方法的实现是为了向客户提供方便，它们将分配和初始化合在一个步骤中， 返回被创建的对象，并
    //    进行自动释放处理。这些方法的形式是+ (type)className...（其中 className不包括任何前缀）。
    //    
    //    工厂方法可能不仅仅为了方便使用。它们不但可以将分配和初始化合在一起，还可以 为初始化过程提供对
    //    象的分配信息。
    //    
    //    类工厂方法的另一个目的是使类（比如NSWorkspace）提供单件实例。虽然init...方法可以确认一
    //    个类在每次程序运行过程只存在一个实例，但它需要首先分配一个“生的”实例，然后还必须释放该实例。
    //    工厂 方法则可以避免为可能没有用的对象盲目分配内存
    //}

#pragma mark-动态绑定
    //{
    //    —在运行时确定要调用的方法
    //    
    //    动态绑定将调用方法的确定也推迟到运行时。在编译时，方法的调用并不和代码绑定 在一起，只有在消息发送出来之后，才确定被调用的代码。通过动态类型和动态绑定技术，您的代码每次执行都可以得到不同的结果。运行时因子负责确定消息的接 收者和被调用的方法。 运行时的消息分发机制为动态绑定提供支持。当您向一个动态类型确定了的对象发送消息时，运行环境系统会通过接收者的isa指针定位对象的类，并以此为起点 确定被调用的方法，方法和消息是动态绑定的。而且，您不必在Objective-C 代码中做任何工作，就可以自动获取动态绑定的好处。您在每次发送消息时，
    //    
    //    特别是当消息的接收者是动态类型已经确定的对象时，动态绑定就会例行而 透明地发生。
    //}

#pragma mark-sprintf,strcpy,memcpy使用上有什么要注意的地方
    //{
    //    strcpy是一个字符串拷贝的函数，它的函数原型为strcpy(char *dst, const char *src);
    //    
    //    将src开始的一段字符串拷贝到dst开始的内存中去，结束的标志符号为 '\0'，由于拷贝的长度不是由我们自己控制的，所以这个字符串拷贝很容易出错。具备字符串拷贝功能的函数有memcpy，这是一个内存拷贝函数，它的函数原型为memcpy(char *dst, const char* src, unsigned int len);
    //    
    //    将长度为len的一段内存，从src拷贝到dst中去，这个函数的长度可控。但是会有内存叠加的问题。
    //    
    //    sprintf是格式化函数。将一段数据通过特定的格式，格式化到一个字符串缓冲区中去。sprintf格式化的函数的长度不可控，有可能格式化后的字符串会超出缓冲区的大小，造成溢出。
    //}

#pragma mark-用变量a给出下面的定义
    //{
    //    a) 一个整型数（An integer）  
    //    b)一 个指向整型数的指针（ A pointer to an integer）  
    //    c)一个指向指针的的指针，它指向的指针是指向一个整型数（ A pointer to a pointer to an intege）r  
    //    d)一个有10个整型数的数组（ An array of 10 integers）  
    //    e) 一个有10个指针的数组，该指针是指向一个整型数的。（An array of 10 pointers to integers）  
    //    f) 一个指向有10个整型数数组的指针（ A pointer to an array of 10 integers）  
    //    g) 一个指向函数的指针，该函数有一个整型参数并返回一个整型数（A pointer to a function that takes an integer as an argument
    //    and returns an integer）  
    //    h) 一个有10个指针的数组，该指针指向一个函数，该函数有一个整型参数并返回一个整型数（ An array of ten pointers to functions t
    //    hat take an integer argument and return an integer ）  
    //    
    //    答 案是：  
    //    a) int a; // An integer  
    //    b) int *a; // A pointer to an integer  
    //    c) int **a; // A pointer to a pointer to an integer  
    //    d) int a[10]; // An array of 10 integers  
    //    e) int *a[10]; // An array of 10 pointers to integers  
    //    f) int (*a)[10]; // A pointer to an array of 10 integers  
    //    g) int (*a)(int); // A pointer to a function a that  takes an integer argument and returns an integer  
    //    h) int (*a[10])(int); // An array of 10 pointers to functions  that take an integer argument and return an integer
    //}

#pragma mark-CALayer和View的关系 
    //{http://www.cnblogs.com/uyoug321/archive/2011/01/22.html
    //    一个UIView包含CALayer树，CALayer是一个数据模型，包含了一些用于显示的对象，但本身不用于显示。 
    //    
    //    CALayer相当于photoshop的一个层，很多动画可以通过设置CALayer来实现。据说有人用CALayer显示图片来播放视频。
    //    
    //    Core animation应该是用CAlayer来实现各种动画。
    //}

#pragma mark-KVO/KVC 实现机理分析
//{     http://blog.csdn.net/kesalin/article/details/8194240
//    Objective-C 中的键(key)-值(value)观察(KVO)并不是什么新鲜事物，它来源于设计模式中的观察者模式，其基本思想就是：
//    一个目标对象管理所有依赖于它的观察者对象，并在它自身的状态改变时主动通知观察者对象。这个主动通知通常是通过调用各观察者对象所提供的接口方法来实现的。观察者模式较完美地将目标对象与观察者对象解耦。
//}

//{
//当指定的对象的属性被修改了，允许对象接受到通知的机制。每次指定的被观察对象的属性被修改的时候，KVO都会自动的去通知相应的观察者
//    Objective-C里面的Key-Value Observing (KVO)机制，非常不错，可以很好的减少浇水代码。关于KVO的学习，可以参考文章：《Key-Value Observing快速入门》：http://www.cnblogs.com/pengyingh/articles/2383629.html
//Key-Value Observing (简写为KVO)：当指定的对象的属性被修改了，允许对象接受到通知的机制。每次指定的被观察对象的属性被修改的时候，KVO都会自动的去通知相应的观察者。
//
//KVO的优点：
//当 有属性改变，KVO会提供自动的消息通知。这样的架构有很多好处。首先，开发人员不需要自己去实现这样的方案：每次属性改变了就发送消息通知。这是KVO 机制提供的最大的优点。因为这个方案已经被明确定义，获得框架级支持，可以方便地采用。开发人员不需要添加任何代码，不需要设计自己的观察者模型，直接可 以在工程里使用。其次，KVO的架构非常的强大，可以很容易的支持多个观察者观察同一个属性，以及相关的值。
//KVO如何工作：
//需要三个步骤来建立一个属性的观察员。理解这三个步骤就可以知道KVO如何设计工作的。 （1）首先，构思一下如下实现KVO是否有必要。比如，一个对象，当另一个对象的特定属性改变的时候，需要被通知到。
//}

//{
//    Key-Value Coding（KVC）实现分析
//
//    KVC运用了一个isa-swizzling技术。isa-swizzling就是类型混合指针机制。KVC主要通过isa-swizzling，来实现其内部查找定位的。isa指针，如其名称所指，（就是is a kind of的意思），指向维护分发表的对象的类。该分发表实际上包含了指向实现类中的方法的指针，和其它数据。
//
//    比如说如下的一行KVC的代码：
//
//    [site setValue:@"sitename" forKey:@"name"];
//
//    就会被编译器处理成：
//
//    SEL sel = sel_get_uid ("setValue:forKey:");
//    IMP method = objc_msg_lookup (site->isa,sel);
//    method(site, sel, @"sitename", @"name");
//
//    首先介绍两个基本概念：
//
//    （1）SEL数据类型：它是编译器运行Objective-C里的方法的环境参数。
//
//    （2）IMP数据类型：他其实就是一个 编译器内部实现时候的函数指针。当Objective-C编译器去处理实现一个方法的时候，就会指向一个IMP对象，这个对象是C语言表述的类型。
//
//    关于如何找到实现函数的指针，可参考文章：《Objective-C如何避免动态绑定，而获得方法地址》：http://www.cocoadev.cn/Objective-C/Get-method-address.asp
//
//    这下KVC内部的实现就很清楚的清楚了：一个对象在调用setValue的时候，（1）首先根据方法名找到运行方法的时候所需要的环境参数。（2）他会从自己isa指针结合环境参数，找到具体的方法实现的接口。（3）再直接查找得来的具体的方法实现。
//
//    Key-Value Observing（KVO）实现
//
//    在上面所介绍的KVC机制上加上KVO的自动观察消息通知机制就水到渠成了。
//
//    当观察者为一个对象的属性进行了注册，被观察对象的isa指针被修改的时候，isa指针就会指向一个中间类，而不是真实的类。所以isa指针其实不需要指向实例对象真实的类。所以我们的程序最好不要依赖于isa指针。在调用类的方法的时候，最好要明确对象实例的类名。
//
//    熟悉KVO的朋友都知道，只有当我们调用KVC去访问key值的时候KVO才会起作用。所以肯定确定的是，KVO是基于KVC实现的。其实看了上面我们的分析以后，关系KVO的架构的构思也就水到渠成了。
//
//    因为KVC的实现机制，可以很容易看到某个KVC操作的Key，而后也很容易的跟观察者注册表中的Key进行匹对。假如访问的Key是被观察的Key，那么我们在内部就可以很容易的到观察者注册表中去找到观察者对象，而后给他发送消息。
//}

#pragma mark-isa
    //{
    //    NSObject里面只有一个变量，就是Class类型的isa。isa的英文的意思就是is a pointer的意思。也就是说NSObject里面只有一个实例变量isa,isa里面保存了对象里面的实例变量相对于对象首地址的偏移量，我们得到了这个偏移量之后就可以根据对象的地址来获得我们所需要的实例变量的地址。在正常情况下，我们需要通过访问类本身和它的超类的ivars来获得偏移量的
    //}

#pragma mark-BOOL值
    //{
    //在Objective-C里面，BOOL其实是signed char，YES是1，NO是0
    //    第一点，从本质上来说BOOL是一个8bit的一个char，所以我们在把其他比如说short或者int转换成为BOOL的时候一定要注意。如果short或者int的最低的8位bit都是0的话，尽管除了最低的8位以外都不是0，那么经过转换之后，就变成了0也就是NO。比如说我们有一个int的值是0X1000，经过BOOL转换之后就变成了NO。 
    //    第二点，Objective-C里面的所有的逻辑判断例如if语句等等和C语言保持兼容，如果数值不是0判断为真，如果数值是0那么就判断为假，并不是说定义了BOOL值之后就变成了只有1或者YES为真。所以下面的代码的判断都为真：
    //    if(0X1000)
    //        if(2)
    //            if(-1)
    //}

#pragma mark-SEL类型
    //{
    //    Objective-C在编译的时候，会根据方法的名字（包括参数序列），生成一个用 来区分这个方法的唯一的一个ID，这个ID就是SEL类型的。我们需要注意的是，只要方法的名字（包括参数序列）相同，那么它们的ID都是相同的。就是 说，不管是超类还是子类，不管是有没有超类和子类的关系，只要名字相同那么ID就是一样的。除了函数名字和ID，编译器当然还要把方法编译成为机器可以执 行的代码，这样，在一个编译好的类里面，就产生了如下图所示方法的表格示意图（本构造属于笔者推测，没有得到官方证实，所以图5-2为示意图仅供参考，我们可以暂时认为是这样的）。
    //    
    //    方法名字(say)   方法ID(1001)  地址(0x2001,函数指针的值,也是函数的入口地址)
    //    
    //    图5-2，方法的表格示意图 
    //    请注意setSkinColor后面有一个冒号，因为它是带参数的。由于存在这样的一个表格，所以在程序执行的时候，我们可以方便的通过方法的名字，获取到方法的ID也就是我们所说的SEL，反之亦然。具体的使用方法如下：
    //    
    //    1     SEL 变量名 = @selector(方法名字);
    //    2     SEL 变量名 = NSSelectorFromString(方法名字的字符串);
    //    3     NSString *变量名 = NSStringFromSelector(SEL参数);
    //    其中第1行是直接在程序里面写上方法的名字，第2行是写上方法名字的字符串，第3行是通过SEL变量获得方法的名字。我们得到了SEL变量之后，可以通过下面的调用来给一个对象发送消息：
    //    
    //    [对象 performSelector:SEL变量 withObject:参数1 withObject:参数2];
    //    这样的机制大大的增加了我们的程序的灵活性，我们可以通过给一个方法传递SEL参数，让这个方法动态的执行某一个方法；我们也可以通过配置文件指定需要执行的方法，程序读取配置文件之后把方法的字符串翻译成为SEL变量然后给相应的对象发送这个消息。
    //    从效率的角度上来说，执行的时候不是通过方法名字而是方法ID也就是一个整数来查找方法，由于整数的查找和匹配比字符串要快得多，所以这样可以在某种程度上提高执行的效率
    //}

#pragma mark-函数指针和IMP
    //{http://wenku.baidu.com/view/a6bd6c040740be1e650e9ac6.html
    ///函数指针是指向函数的指针变量。 因而“函数指针”本身首先应是指针变量，只不过该指针变量指向函数。这正如用指针变量可指向整型变量、字符型、数组一样，这里是指向函数。如前所述，C在编译时，每一个函数都有一个入口地址，该入口地址就是函数指针所指向的地址。有了指向函数的指针变量后，可用该指针变量调用函数，就如同用指针变量可引用其他类型变量一样，在这些概念上是一致的。函数指针有两个用途：调用函数和做函数的参数。
    //顾名思义，函数指针就是函数的指针。它是一个指针，指向一个函数。看例子：
    //A) char * (*fun1)(char * p1,char * p2);
    //B) char * *fun2(char * p1,char * p2); 
    //C) char * fun3(char * p1,char * p2);  
    //看看上面三个表达式分别是什么意思？ C）：这很容易，fun3 是函数名，p1，p2 是参数，其类型为char *型，函数的返回值为char *类型。 B)：也很简单，与C）表达式相比，唯一不同的就是函数的返回值类型为char**，是个二级指针。 A)：fun1 是函数名吗？回忆一下前面讲解数组指针时的情形。我们说数组指针这么定义或许更清晰： int (*)[10] p； 再看看A）表达式与这里何其相似！明白了吧。这里fun1 不是什么函数名，而是一个指针变量，它指向一个函数。这个函数有两个指针类型的参数，函数的返回值也是一个指针。同样，我们把这个表达式改写一下：char * (*)(char * p1,char * p2) fun1; 这样子是不是好看一些呢？只可惜编译器不这么想。

    //    在讲解函数指针之前，我们先参看一下图5-2，函数指针的数值实际上就是图5-2里面的地址，有人把这个地址称为函数的入口地址。在图5-2里面我们可以通过方法名字取得方法的ID，同样我们也可以通过方法ID也就是SEL取得函数指针，从而在程序里面直接获得方法的执行地址。获得函数指针的方法有2种，第一种是传统的C语言方式，请参看“DoProxy.h” 的下列代码片断：
    //    1     void(*setSkinColor_Func) (id, SEL, NSString*);//*setSkinColor_Func是指向函数的指针
    //    2     IMP say_Func;
    //    其中第1行我们定义了一个C语言里面的函数指针，关于C语言里面的函数指针的定义以及使用方法，请参考C语言的书籍和参考资料。在第一行当中，值得我们注意的是这个函数指针的参数序列：
    //    
    //    第一个参数是id类型的，就是消息的接受对象，在执行的时候这个id实际上就是self，因为我们将要向某个对象发送消息。
    //    
    //    第二个参数是SEL，也是方法的ID。有的时候在消息发送的时候，我们需要使用用_cmd来获取方法自己的SEL，也就是说，方法的定义体里面，我们可以通过访问_cmd得到这个方法自己的SEL。 
    //    第三个参数是NSString*类型的，我们用它来传递skin color。在Objective-C的函数指针里面，只有第一个id和第二个SEL是必需的，后面的参数有还是没有，如果有那么有多少个要取决于方法的声明。 
    //    现在我们来介绍一下Objective-C里面取得函数指针的新的定义方法，IMP。
    //    
    //    上面的代码的第一行比较复杂，令人难以理解，Objective-C为我们定义了一个新的数据类型就是在上面第二行代码里面出现的IMP。我们把鼠标移动到IMP上，单击右键之后就可以看到IMP的定义，IMP的定义如下：
    //    typedef id                      (*IMP)(id, SEL, );
    //    这个格式正好和我们在第一行代码里面的函数指针的定义是一样的。
    //    
    //    我们取得了函数指针之后，也就意味着我们取得了执行的时候的这段方法的代码的入口，这样我们就可以像普通的C语言函数调用一样使用这个函数指针。当然我们可以把函数指针作为参数传递到其他的方法，或者实例变量里面，从而获得极大的动态性。我们获得了动态性，但是付出的代价就是编译器不知道我们要执行哪一个方法所以在编译的时候不会替我们找出错误，我们只有执行的时候才知道，我们写的函数指针是否是正确的。所以，在使用函数指针的时候要非常准确地把握能够出现的所有可能，并且做出预防。尤其是当你在写一个供他人调用的接口API的时候，这一点非常重要。
    //}

#pragma mark-Class类型
    //{
    //    到目前为止，我们已经知道了对应于方法的SEL数据类型，和SEL同样在Objective-C里面我们不仅仅可以使用对应于方法的SEL，对于类在Objective-C也为我们准备了类似的机制，Class类型。当一个类被正确的编译过后，在这个编译成功的类里面，存在一个变量用于保存这个类的信息。我们可以通过一个普通的字符串取得 这个Class，也可以通过我们生成的对象取得这个Class。Class被成功取得之后，我们可以把这个Class当作一个已经定义好的类来使用它。这样的机制允许我们在程序执行的过程当中，可以Class来得到对象的类，也可以在程序执行的阶段动态的生成一个在编译阶段无法确定的一个对象。
    //    
    //    因为Class里面保存了一个类的所有信息，当然，我们也可以取得一个类的超类。关于Class类型，具体的使用格式如下：
    //    
    //    1     Class 变量名 = [类或者对象 class];
    //    2     Class 变量名 = [类或者对象 superclass];
    //    3     Class 变量名 = NSClassFromString(方法名字的字符串);
    //    4     NSString *变量名 = NSStringFromClass(Class参数);
    //    第一行代码，是通过向一个类或者对象发送class消息来获得这个类或者对象的Class变量。
    //    
    //    第二行代码，是通过向一个类或者对象发送superclass消息来获得这个类或者对象的超类的Class变量。
    //    
    //    第三行代码，是通过调用NSClassFromString函数，并且把一个字符串作为参数来取得Class变量。这个在我们使用配置文件决定执行的时候的类的时候，NSClassFromString给我们带来了极大的方便。
    //    
    //    第四行代码，是NSClassFromString的反向函数NSStringFromClass，通过一个Class类型作为变量取得一个类的名字。
    //    
    //    当我们在程序里面通过使用上面的第一，二或者第三行代码成功的取得一个Class类型的变量，比如说我们把这个变量名字命名为myClass，那么我们在以后的代码种可以把myClass当作一个我们已经定义好的类来使用，当然我们可以把这个变量作为参数传递到其他的方法当中让其他的方法动态的生成我们需要的对象。
    //}

#pragma mark-二维码
    //{
    //    二维码是用特定的几何图形按一定规律在平面（二维方向上）分布的黑白相间的矩形方阵记录数据符号信息的新一代条码技术，由一个二维码矩阵图形和一个二维码号，以及下方的说明文字组成，具有信息量大，纠错能力强，识读速度快，全方位识读等特点
    //将手机需要访问、使用的信息编码到二维码中，利用手机的摄像头识读，这就是手机二维码。手机二维码可以印刷在报纸、杂志、广告、图书、包装以及个人名片等多种载体上，用户通过手机摄像头扫描二维码或输入二维码下面的号码、关键字即可实现快速手机上网，快速便捷地浏览网页、下载图文、音乐、视频、获取优惠券、参与抽奖、了解企业产品信息，而省去了在手机上输入URL的繁琐过程，实现一键上网。
    //}

#pragma mark-NSUserDefaults
    //{http://huli13758125066.blog.163.com/blog/static/16773812720116313334836/
    //存储的位置：<UUID for your App>\Library\Preferences\<your App's bundle ID>.plist
//NSUserDefaults类用于保存应用程序设置和属性以及用户数据。例如，你可以存储用户在应用程序中使用的图片或默认颜色方案。这些对象存储在iOS所谓的“defaults系统”中。iOS的defaults系统在整个app中都是可用的，因此存放到defaults系统中的数据也是整个应用程序生命周期中可用的。也就是说，无论用户关闭程序还是关机，在用户再次打开程序或开机后这些数据仍然存在。NSUserDefaults可以存储的数据类型包括：
//
//NSData
//NSString
//NSNumber
//NSDate
//NSArray
//NSDictionary
//如果你想保存其他类型，如UIImage，你应该进行编码（即archive），或者将它转换为NSData、NSNumber或者NSString。
    //}

#pragma mark-memset
    //{
    //    void *memset(void *, int, size_t);//把较大的结构体里的每个值清成第二个参数的值
    //}

#pragma mark-initialize
    //{
    //    NSObject的initialize函数在init函数前回调
    //}

#pragma mark-__builtin_va_list
    //{ http://baike.baidu.com/view/1213054.htms

//typedef struct {
//    char *a0; /* pointer to first homed integer argument */ 可变参数列表的第一个参数的地址
//    int offset; /* byte offset of next parameter */
//} va_list;

    //    typedef __builtin_va_list va_list;//GCC(处理各种语言的编译器)的内部(可变数组)类型

    //}

#pragma mark-id,Class,SEL,IMP
    //{
    //    id类型的变量可指向任何类的对象,是英文identifier的缩写，我们在很多地方都遇到过id，比如说在博客园里面，我们都使用id来登陆系统的，我们的id就代表着系统的一个用户。由于id在一个系统当中是唯一的，所以系统获得我们的id之后就知道我们是谁了。Objective-C也是一样的道理，使用id来代表一个对象，在Objective-C当中，所有的对象都可以使用id来进行区分。我们知道一个类仅仅是一些数据外加上操作这些数据的代码，所以id实际上是指向数据结构的一个指针而已，相当于void*。
    //    Class可指向任何类型,类的信息都保存在Class里面
    //    SEL可指向任何方法,就是包括方法名字等等的信息
    //    IMP可指向任何函数，实现与SEL类似功能，但效率更高,指向类的方法的入口地址，它和普通的C函数不是完全兼容的。IMP是执行代码的入口地址,8里面就直接存储着函数地址，那么编译器就可以直接调用。这样一来就完全避免了查表的过程，也就是直接调用，所以效率就更高。
    //}

#pragma mark-protected,public,private
    //{
    //    如果一个实例变量没有任何的作用域限定的话，那么缺省就是protected。
    //    
    //    如果一个实例变量适用于public作用域限定，那么这个实例变量对于这个类的派生类，还有类外的访问都是允许的。
    //    
    //    如果一个实例变量适用于private作用域限定，那么仅仅在这个类里面才可以访问这个变量。(也可以在类外通过指针偏移得到私有变量,看 http://www.cnblogs.com/yaski/archive/2009/04/19/1439304.html)
    //    
    //    如果一个实例变量适用于protected作用域限定，那么在这个类里面和这个类的派生类里面可以访问这个变量，在类外的访问是不推荐的。
    //}

#pragma mark-类成员视图变量的释放removeFromSuperview
    //{     http://blog.csdn.net/likendsl/article/details/7573504
    //    类成员变量视图被父视图addSubView后,可以release,以后在释放父视图前,只需要把此子视图removeFromSuperview和=nil即可,不需要再次release;否则在释放父视图前需要release此子视图,具体看AlreadyActivatedTwo_DimensionalcodeViewController类的
    //- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
    //函数

//释放一个视图前,要先释放此视图里的子视图
//for(UIView *view in [v subviews])
//{
//    [view removeFromSuperview];
//}
//[v removeFromSuperview];

    //}

#pragma mark-UIScrollView的contentInset
    //{
    //        //http://blog.csdn.net/ccf0703/article/details/7595014
    //内容视图的上下左右四个边扩展出去的大小
    //}

#pragma mark-超类和子类中的Class,objc_object,具体参考 MyNSObject.h
    //{
    //在类进行内存分配的时候，对于一个类而言，runtime需要找到这个类的超类，然后把超类的Class的指针的地址赋值给isa里面的super_class
    //}

#pragma mark-iVars
    //{   http://www.cnblogs.com/cloudayc/archive/2012/10/31/2745336.html  http://www.cocoachina.com/downloads/video/2010/1018/2198.html
    //实体变量（instance variables)

//Objective-C运行时库提供了非常便利的方法获取其对象运行时所属类及其所有成员变量，并通过KVC进行值的存取。
//在某些场合，若想遍历某个对象的所有成员变量的值，或将其转化为NSDictionary这样的key-value集合，亦或将其转化为一个网络请求的POST参数，都可以通过OC的运行时编程来解决。
//如将当前类所有成员转化为NSDictionary集合

//struct objc_ivar {
//    char *ivar_name                                          OBJC2_UNAVAILABLE;
//    char *ivar_type                                          OBJC2_UNAVAILABLE;
//    int ivar_offset                                          OBJC2_UNAVAILABLE;
//#ifdef __LP64__
//    int space                                                OBJC2_UNAVAILABLE;
//#endif
//} OBJC2_UNAVAILABLE;
//
//typedef struct objc_ivar *Ivar;

    //}

#pragma mark-self
    //{
    //1，实例方法里面的self，是对象的首地址。
    //
    //2，类方法里面的self，是Class.
    //
    //尽管在同一个类里面的使用self，但是self却有着不同的解读。在类方法里面的self，可以翻译成class self；在实例方法里面的self，应该被翻译成为object self。在类方法里面的self和实例方法里面的self有着本质上的不同，尽管他们的名字都叫self。
    //}

#pragma mark-动态方法替换,FINAL,让子类重写父类的方法后调子类的重写方法时还调父类的方法  
    //{     http://www.cnblogs.com/yaski/archive/2009/04/29/1444035.html
    //        //使用动态方法替换实现final功能
    //	SEL sayName = @selector(methodName/*方法名字*/);
    //        //取得方法的数据结构 Method
    //	Method unknownSubClassSaySomething = class_getInstanceMethod([self/*子类的类指针*/ class], sayName);
    //        //Change the subclass method is RUDE!
    //	Method cattleSaySomething = class_getInstanceMethod([Cattle/*父类*/ class], sayName);
    //        //method_imp is deprecated since 10.5
    //	unknownSubClassSaySomething->method_imp = cattleSaySomething->method_imp;//把子类的函数指针的地址替换成为Cattle类的saySomething，这样无论子类是否重写saySomething， 执行的时候由于runtime需要找到方法的入口地址，但是这个地址总是被我们替换为Cattle的saySomething，所以子类通过 cattleWithLegsCountVersionD取得对象之后，总是调用的Cattle的saySomething，也就实现了final。当 然，这种方法有些粗鲁，我们强行的不顾后果的替换了子类的重写。把UnknownBull的saySomething变成了Cattle的saySomething

    //关于final的实现方式，我们当然可以使用一个文明的方法来告知子类的使用者，我们不想让某个方法被重写。我们只需要定义一个宏
#define FINAL
    //类的使用者看到这个FINAL之后，笔者相信在绝大多数时候，他会很配合你不会重写带FINAL定义的方法的,但是如果他重写了,还是会先回调子类重写的函数

    //}

#pragma mark-home,程序退至后台  
//{
//    按home小退后,程序的timer暂停,图层动画停止,但是网络多线程貌似没停
//}

#pragma mark-通知中心  
    //{http://www.devdiv.com/iOS_iPhone-%E5%88%9D%E8%AF%86iOS%E4%B8%AD%E7%9A%84%E9%80%9A%E7%9F%A5%E4%B8%AD%E5%BF%83%E3%80%90%E5%9B%BE%E6%96%87%E8%A7%A3%E8%AF%B4%E3%80%91-thread-130016-1-2.html
    //    通知中心实际上是在程序内部提供了消息广播的一种机制。通知中心不能在进程间进行通信。实际上就是一个二传手，把接收到的消息，根据内部的一个消息转发表，来将消息转发给需要的对象。通知中心是基于观察者模式的，它允许注册、删除观察者
    //}

#pragma mark-viewDidUnload与didReceiveMemoryWarining 当系统内存吃紧的时候会调用该方法（注：viewController没有被dealloc）
//{http://zyc-to.blog.163.com/blog/static/17152400201011299129231/
//    [super viewDidUnload]会把viewController.view  release  一次;放在 viewDidUnload里的第几行无所谓;
//    在 viewDidUnload 里 removeFromSuperview一般不需要调用,直接=nil即可;
//内存吃紧时，在iPhone OS 3.0之前didReceiveMemoryWarning是释放无用内存的唯一方式，但是OS 3.0及以后viewDidUnload方法是更好的方式
//在该方法中将所有IBOutlet（无论是property还是实例变量）置为nil（系统release view时已经将其release掉了）
//在该方法中释放其他与view有关的对象、其他在运行时创建（但非系统必须）的对象、在viewDidLoad中被创建的对象、缓存数据等
//release对象后，将对象置为nil（IBOutlet只需要将其置为nil，系统release view时已经将其release掉了）
//一般认为viewDidUnload是viewDidLoad的镜像，因为当view被重新请求时，viewDidLoad还会重新被执行
//viewDidUnload中被release的对象必须是很容易被重新创建的对象（比如在viewDidLoad或其他方法中创建的对象），不要release用户数据或其他很难被重新创建的对象

    //http://blog.csdn.net/tangaowen/article/details/8511399
//{ios 内存不足的处理（ios6 与 ios 6之前分部处理）
//    自从iPhone4 支持多任务后，我们需要更加仔细处理内存不足的情形。如果用户运行我们程序的时候，后台还跑着N个软件，那前台运行的iphone 程序就很容易收到内存不足的警告。
//
//    通常情况下，iOS在内存不足时会给用户一次处理内存资源的机会。当我们的程序在第一次收到内存不足警告时，应该释放一些不用的资源，以节省部分内存。否则，当内存不足情形依然存在，iOS再次向我们程序发出内存不足的警告时，我们的程序将会被iOS kill掉。
//    iOS的UIViewController 类给我们提供了处理内存不足的接口。在iOS 3.0 之前，当系统的内存不足时，UIViewController的didReceiveMemoryWarining 方法会被调用，我们可以在didReceiveMemoryWarining 方法里释放掉部分暂时不用的资源。
//    从iOS3.0 开始，UIViewController增加了viewDidUnload方法。该方法和viewDIdLoad相配对。当系统内存不足时，首先UIViewController的didReceiveMemoryWarining 方法会被调用，而didReceiveMemoryWarining 会判断当前ViewController的view是否显示在window上，如果没有显示在window上，则didReceiveMemoryWarining 会自动将viewcontroller 的view以及其所有子view全部销毁，然后调用viewcontroller的viewdidunload方法。如果当前UIViewController的view显示在window上，则不销毁该viewcontroller的view，当然，viewDidunload也不会被调用了。
//
//    但是到了ios6.0之后，这里又有所变化，ios6.0内存警告的viewDidUnload 被屏蔽，即又回到了ios3.0的时期的内存管理方式。
//
//    iOS3-iOS6.0以前版本收到内存警告：
//    调用didReceiveMemoryWarning内调用super的didReceiveMemoryWarning会将controller的view进行释放。所以我们不能将controller的view再次释放。
//    处理方法：
//    -(void)didReceiveMemoryWarning
//    {
//    [super didReceiveMemoryWarning];//如没有显示在window上，会自动将self.view释放。
//                                    // ios6.0以前，不用在此做处理，self.view释放之后，会调用下面的viewDidUnload函数，在viewDidUnload函数中做处理就可以了。
//    }
//    -(void)viewDidUnload
//    {
//        // Release any retained subviews of the main view.不包含self.view
//    [super viewDidUnload];
//
//        //处理一些内存和资源问题。
//    }
//
//    iOS6.0及以上版本的内存警告：
//    调用didReceiveMemoryWarning内调用super的didReceiveMemoryWarning调只是释放controller的resouse，不会释放view
//    处理方法：
//    -(void)didReceiveMemoryWarning
//    {
//    [super didReceiveMemoryWarning];//即使没有显示在window上，也不会自动的将self.view释放。
//                                    // Add code to clean up any of your own resources that are no longer necessary.
//
//        // 此处做兼容处理需要加上ios6.0的宏开关，保证是在6.0下使用的,6.0以前屏蔽以下代码，否则会在下面使用self.view时自动加载viewDidLoad
//
//    float sysVer =[[[UIDevicecurrentDevice] systemVersion] floatValue];
//
//    if (sysVer>= 6.0f)
//        {
//
//        if ([self.view window] == nil)// 是否是正在使用的视图
//            {
//                // Add code to preserve data stored in the views that might be
//                // needed later.
//
//                // Add code to clean up other strong references to the view in
//                // the view hierarchy.
//            self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
//            }
//
//        }
//
//    }
//}

//viewDidUnload 和 dealloc 的区别     http://hi.baidu.com/wwssttt/item/1f0f08d41d80dfc81a72b4d7
//}


#pragma mark-UITableViewCell 的重用机制
//{http://www.cnblogs.com/hellocby/archive/2012/05/23/2514469.html
//    UITableView通过重用单元格来达到节省内存的目的:通过为每个单元格指定一个重用标识符(reuseIdentifier),即指定了单元格的种类,以及当单元格滚出屏幕时,允许恢复单元格以便重用.对于不同种类的单元格使用不同的ID,对于简单的表格,一个标识符就够了.
//    
//    假如一个TableView中有10个单元格,但是屏幕上最多能显示4个,那么实际上iPhone只是为其分配了4个单元格的内存,没有分配10个,当滚动单元格时,屏幕内显示的单元格重复使用这4个内存;
//    实际上分配的Cell个数为屏幕最大显示数, 当有新的Cell进入屏幕时,会随机调用已经滚出屏幕的Cell所占的内存,这就是Cell的重用
//}

#pragma mark-UITableView
//{http://www.cnblogs.com/smileEvday/archive/2012/06/28/tableView.html
//}

#pragma mark-armv7
//{
//    编译器对象:是应用程序的视图对象和模型对象之间的协调者。
//}

#pragma mark-sqlite3数据库 
//{     http://www.cnblogs.com/wengzilin/archive/2012/03/27/2419855.html    http://blog.csdn.net/totogo2010/article/details/7702207  http://blog.163.com/lzb4319@126/blog/static/7255470020121824641836/
//先加入sqlite开发库libsqlite3.dylib，
//新建或打开数据库，
//创建数据表，
//插入数据，
//查询数据并打印
//}

#pragma mark-在控制台用po(print-object) 变量名 查看内存中的数据及print查看对象的retainCount
//{//  http://blog.csdn.net/shuixin536/article/details/7762990

//在GDB窗口中使用po就可以查看变量.(po = print object)
//1）查看String 或其它变量。
//po 变量名
//2）查看某个Property。比如要查看item变量的name属性。
//po [item name]    注意，po item.name是不工作的。
//3）查看数组
//po [myArray objectAtIndex:index]

// print (int)[object retainCount]; 打印某对象的retainCount
//}

#pragma mark-左右移位>> 或 << 或 |
//{
//    a=1<< 1;     2
//    b=1<< 2;     4
//    c=a|b;       6;   // |就是+
//}

#pragma mark-UIViewController容器机理分析
//{
//    http://windshg.iteye.com/blog/1683897
//}

#pragma mark-associative:动态扩展对象的属性
//{  http://www.cnblogs.com/liping13599168/archive/2012/09/13/2682664.html
    //http://www.guokr.com/blog/203413/
//associative，可以通过它来动态扩展对象的属性；要用它必须使用<objc/runtime.h>的头文件

//OBJC_EXPORT void objc_setAssociatedObject(id object/*待扩展的对象实例*/, const void *key/*该对象实例的要扩展的属性的键*/, id value/*对象实例的要扩展的属性的值*/, objc_AssociationPolicy policy/*对象的要扩展的属性的关联的策略*/)__OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_3_1);
//OBJC_EXPORT id objc_getAssociatedObject(id object, const void *key)
//__OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_3_1);
//}

#pragma mark-addChildViewController
//{ http://blog.csdn.net/chengyingzhilian/article/details/8498998
//    在以前，一个UIViewController的View可能有很多小的子view。这些子view很多时候被盖在最后，我们在最外层ViewController的viewDidLoad方法中，用addSubview增加了大量的子view。这些子view大多数不会一直处于界面上，只是在某些情况下才会出现，例如登陆失败的提示view，上传附件成功的提示view，网络失败的提示view等。但是虽然这些view很少出现，但是我们却常常一直把它们放在内存中。另外，当收到内存警告时，我们只能自己手工把这些view从super view中去掉。
//    
//    改变
//    
//    苹果新的API增加了addChildViewController方法，并且希望我们在使用addSubview时，同时调用[self addChildViewController:child]方法将sub view对应的viewController也加到当前ViewController的管理中。对于那些当前暂时不需要显示的subview，只通过addChildViewController把subViewController加进去。需要显示时再调用transitionFromViewController:toViewController:duration:options:animations:completion方法。
//    
//    另外，当收到系统的Memory Warning的时候，系统也会自动把当前没有显示的subview unload掉，以节省内存。
//}


#pragma mark-@dynamic
//{
//告诉编译器自己要手动写一个类成员变量的set和get方法,不用编译器生成,@synthesize是 编译器自动生成get和set方法,但自己可以重写
//@dynamic 就是要来告诉编译器，代码中用@dynamic修饰的属性，其getter和setter方法会在程序运行的时候或者用其他方式动态绑定，以便让编译器通过编译。其主要的作用就是用在NSManageObject对象的属性声明上，由于此类对象的属性一般是从Core Data的属性中生成的，Core Data框架会在程序运行的时候为此类属性生成getter和Setter方法。

//使用@synthesize编译器会确实的产生getter和setter方法，而@dynamic仅仅是告诉编译器这两个方法在运行期会有的，无需产生警告。
//假设有这么个场景，B类，C类分别继承A类，A类实现某个协议（@protocol），协议中某个属性( somePropety )我不想在A中实现，而在B类，C类中分别实现。如果A中不写任何代码，编译器就会给出警告：
//“use @synthesize, @dynamic or provide a method implementation"
//这时你给用@dynamic somePropety; 编译器就不会警告，同时也不会产生任何默认代码。

//类别里声明的变量,最好用@dynamic修饰,在set和get方法里用objc_setAssociatedObject和objc_getAssociatedObject来设置和获取变量,如 
//}


#pragma mark-@synchronized(self){}
//{     http://blog.csdn.net/sanpintian/article/details/8139635
//    @synchronized(self) {
//            //something like this
//    }
//}

#pragma mark-避免跑进真机的项目覆盖之前真机里的项目
//{
//    在项目的plist里的 Bundle identifier里改
//}

#pragma mark-NSMutableAttributedString和CoreText 总结 
//{
//http://ios-iphone.diandian.com/post/2012-03-06/15104770
//http://www.dapps.net/dev/iphone/how-to-create-a-simple-magazine-app-with-core-text.html
//http://blog.csdn.net/fengsh998/article/details/8700627
//http://blog.sina.com.cn/s/blog_5102c0360100uv9l.html
//http://www.zhfish.net/2012/10/coretext-touch%E4%BA%8B%E4%BB%B6%E5%A4%84%E7%90%86%E7%AC%94%E8%AE%B0/ 点击事件处理
//}

#pragma mark-UIViewController内存管理
//{
//http://blog.163.com/consultants_clxy/blog/static/2008541192012080012730/
//}

#pragma mark-loadView
//{
//    [super loadView];//创建viewController.view
//}

#pragma mark-dealloc
//{
//    [super dealloc];  http://www.linuxidc.com/Linux/2012-04/57904.htm     http://blog.zjuhz.com/archives/378      http://blog.sina.com.cn/s/blog_71715bf80101a6qu.html
//}

#pragma mark-instrunments里的overall  living
//{
////    overall:被释放的次数
////    overall Bytes :被释放的总大小
////living: 此类型对象当前存活 的的数量s
//}

#pragma mark-layoutSubviews
//{
//http://blog.csdn.net/bsplover/article/details/7977944
//}

#pragma mark-CFArrayCallBacks
//{  http://www.cnblogs.com/lilfqq-IOS/archive/2012/04/20.html

//typedef struct {
//    CFIndex                version;
//    CFArrayRetainCallBack        retain;
//    CFArrayReleaseCallBack        release;
//    CFArrayCopyDescriptionCallBack    copyDescription;
//    CFArrayEqualCallBack        equal;
//} CFArrayCallBacks;

//  对array进行操作的回调函数结构体，我们可以通过自定义这个结构提里面的每个字段来进行一些自定义的操作，就是说要自行定义一种容器，比如非retain型的NSMutableArray
//}

#pragma mark-[_tableView reloadData]
//{
//    [_tableView reloadData] 之后第一次调 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 等回调函数时indexPath重置成(0,0)
//
//}

#pragma mark-- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
//{
//    http://blog.csdn.net/leonpengweicn/article/details/8365079
//    http://tech.cncms.com/shouji/iphone/97108.html

//使用后只回调 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 方法

//}

#pragma mark-CFURLCreateStringByAddingPercentEscapes 转义字符
//{
//http://www.cnblogs.com/meyers/archive/2012/04/26/2471669.html
//http://blog.csdn.net/z251257144/article/details/7566791

//http://www.cnblogs.com/VincentXue/archive/2013/02/27/2934854.html
//OC里面的'\'是转义符,不能直接用@"\"之类的表示,

//\a - Sound alert
//\b - 退格
//\f - Form feed
//\n - 换行
//\r - 回车
//\t - 水平制表符
//\v - 垂直制表符
//\\ - 反斜杠
//\" - 双引号
//\' - 单引号

//}


    //===========================后台网络相关=======================================

#pragma mark- 后台网络相关
#pragma mark-HTTP 
    //{http://wenku.baidu.com/view/9fc10d6c1eb91a37f1115c86.html?from=rec&pos=0&weight=2&lastweight=1&count=5
    //    HTTP的post请求时,必须发的有 "Content-Type",  "content-lengh"数据长度ASI库可能帮助发了
    //    
    //    HTTP请求分3部分：请求行，消息报头，请求正文
    //    请求行：以一个请求方法符号(GET或POST或其他)开头,空格分开,后边是请求的Request-URI(链接地址后边的同一资源标识符,如/form.html,url网址链接在消息报头的HOST字段里)和协议版本(如HTTP/1.1),最后是(CRLF)(表示回车或换行);
    //    GET方法表示获取Request-URI标示的资源;POST方法表示在Request-URI标示的资源后附加新数据;
    //    
    //    HTTP请求响应也分3部分：状态行  ，消息报头，响应正文
    //    状态行格式:   HTTP-Version  Status-Code  Reason-Phrase CRLF	
    //    HTTP-Version:服务器的HTTP协议版本 
    //    Status-Code:表示服务发回的响应状态代码;详见 (U盘---Status-Code详解.png)
    //    Reason-Phrase:状态代码的文本描述;
    //    
    //    消息报头分 普通报头,请求报头,响应报头,实体报头
    //    请求报头:允许客户端向服务器传递请求的附加信息及客户端自身的信息;
    //    响应报头:允许服务器传递不能放在状态行中的附加响应值及服务器的信息和对Request-URI所标示的资源进一步访问的信息; 
    //    实体报头:定义了关于实体正文(不一定实体报头域和实体正文压迫一起发,可只发实体报头域)和请求所标示的资源的元信息(如 Content-Type:text/html   此实体报头域指定发送给接受者的实体正文的类型;  Content-Length:100  表示实体正文长度,以字节方式存储的十进制数 );
    //}

#pragma mark-ASIHTTPRequest
//{
//      http://blog.csdn.net/workhardupc100/article/details/6941685
//}

#pragma mark-TCP/IP协议,Socket
//{
//TCP:全称是Transmission Control Protocol，中文名为传输控制协议，它可以提供可靠的、面向连接的网络数据传递服务。
//TCP的连接建立过程又称为TCP三次握手。首先发送方主机向接收方主机发起一个建立连接的同步（SYN）请求；接收方主机在收到这个请求后向发送方主机回复一个同步/确认（SYN/ACK）应答；发送方主机收到此包后再向接收方主机发送一个确认（ACK），此时TCP连接成功建立
//IP 地址和端口号合在一起被称为“套接字”
//http://soft.zdnet.com.cn/software_zone/2009/1206/1539026.shtml

//Socket接口是TCP/IP网络的API，Socket接口定义了许多函数或例程，程序员可以用它们来开发TCP/IP网络上的应用程序。要学Internet上的TCP/IP网络编程，必须理解Socket接口。
//Socket接口设计者最先是将接口放在Unix操作系统里面的。如果了解Unix系统的输入和输出的话，就很容易了解Socket了。网络的Socket数据传输是一种特殊的I/O，Socket也是一种文件描述符。Socket也具有一个类似于打开文件的函数调用Socket()，该函数返回一个整型的Socket描述符，随后的连接建立、数据传输等操作都是通过该Socket实现的。常用的Socket类型有两种：流式Socket（SOCK_STREAM）和数据报式Socket（SOCK_DGRAM）。流式是一种面向连接的Socket，针对于面向连接的TCP服务应用；数据报式Socket是一种无连接的Socket，对应于无连接的UDP服务应用。

//}


#pragma mark-CFReadStream和CFWriteStream
//{
//    CFWriteStream与CFReadStream不同的一点就是，CFWriteStream不保证接收所有你传入的字节
//    他们的生命周期都经历Create,Open,Read/Write,Close,Release,NULL，之间穿插检错代码。
//    他们与文件File，Buffer缓冲有关。Create时，与File联系成为一体，读取CFReadStream，就相当于读取文件。写入CFWriteStream就相当于写入文件。其实质是Stream代替文件，执行Buffer与File之间的数据交互
//}
