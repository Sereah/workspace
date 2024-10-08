#### 标准库

##### printf

| 格式字符 | 意义                                                         |
| :------: | :----------------------------------------------------------- |
|   a, A   | 以十六进制形式输出浮点数(C99 新增)。实例 **printf("pi=%a\n", 3.14);** 输出 **pi=0x1.91eb86p+1**。 |
|    d     | 以十进制形式输出带符号整数(正数不输出符号)                   |
|    o     | 以八进制形式输出无符号整数(不输出前缀0)                      |
|   x,X    | 以十六进制形式输出无符号整数(不输出前缀Ox)                   |
|    u     | 以十进制形式输出无符号整数                                   |
|    f     | 以小数形式输出单、双精度实数                                 |
|   e,E    | 以指数形式输出单、双精度实数                                 |
|   g,G    | 以%f或%e中较短的输出宽度输出单、双精度实数                   |
|    c     | 输出单个字符                                                 |
|    s     | 输出字符串                                                   |
|    p     | 输出指针地址                                                 |
|    lu    | 32位无符号整数                                               |
|   llu    | 64位无符号整数                                               |
|    zu    | 使用sizeof的时候用这个                                       |



##### 转义

| 转义序列 |    含义    |
| :------: | :--------: |
|    \n    |   换行符   |
|    \t    |   制表符   |
|    \r    |   回车符   |
|   \\\    |   反斜杠   |
|   \\"    |   双引号   |
|   \\'    |   单引号   |
|    \b    |   退格符   |
|    \f    |   换页符   |
|    \v    | 垂直制表符 |
|    \0    |   空字符   |
|    \a    |   响铃符   |



#### 变量

全局变量和静态变量的默认值为 **0**，字符型变量的默认值为 **\0**，指针变量的默认值为 NULL，而**局部变量没有默认值**，其初始值是未定义的。

##### 声明和定义

```C
extern int i; //声明，不是定义，无储存空间
int i; //声明，也是定义，有储存空间
```

C 语言中变量的默认值取决于其类型和作用域。全局变量和静态变量的默认值为 **0**，字符型变量的默认值为 **\0**，指针变量的默认值为 NULL，而**局部变量没有默认值**，其初始值是未定义的。

##### 如何理解extern关键字

作用是告诉编译器在当前文件中有一个变量或函数的声明，但是它的定义在其他文件中，编译器在链接时会去找到该变量或函数的定义。这样就可以在一个文件中使用另一个文件中定义的变量或函数。

> 声明外部函数可以省略extern，通常做法是将声明放在头文件中，定义变量/函数的文件和使用外部变量/函数的文件引入头文件。

```c
#include<stdio.h>

int add_fun();
int x = 2;
int y = 3;
int z = 4;

int main()
{
	int x = 1;
    int y = 2;
	int result;
	result = add_fun();
	printf("result: %d\n", result);
	return 0;
}	
```

```c
#include<stdio.h>

extern int x;
extern int y;

int add_fun()
{
    extern int z;
    return x+y+z;
}
```

##### 左值和右值

1. **左值（lvalue）：**指向内存位置的表达式被称为左值（lvalue）表达式。左值可以出现在赋值号的左边或右边。
2. **右值（rvalue）：**术语右值（rvalue）指的是存储在内存中某些地址的数值。右值是不能对其进行赋值的表达式，也就是说，右值可以出现在赋值号的右边，但不能出现在赋值号的左边。

#### 常量

##### 前缀指定基数

0x 或 0X 表示十六进制，0 表示八进制，不带前缀则默认表示十进制。

##### 后缀

U 和 L 的组合，U 表示无符号整数（unsigned），L 表示长整数（long）。后缀可以是大写，也可以是小写，U 和 L 的顺序任意。

###### 无符号整数

```C
unsigned int x;
```

用于存储非负整数

###### 浮点整数

```C
3.14159       /* 合法的 */
314159E-5L    /* 合法的 */
510E          /* 非法的：不完整的指数 */
210f          /* 非法的：没有小数或指数 */
.e55          /* 非法的：缺少整数或分数 */
```

###### 字符串常量

字符串常量在内存中以 **null** 终止符 **\0** 结尾。

##### 定义常量

1. 使用 **#define** 预处理器： #define 可以在程序中定义一个常量，它在编译时会被替换为其对应的值。
2. 使用 **const** 关键字：const 关键字用于声明一个只读变量，即该变量的值不能在程序运行时修改。

###### #define 与 const 区别

- 替换机制：`#define` 是进行简单的文本替换，而 `const` 是声明一个具有类型的常量。`#define` 定义的常量在编译时会被直接替换为其对应的值，而 `const` 定义的常量在程序运行时会分配内存，并且具有类型信息。
- 类型检查：`#define` 不进行类型检查，因为它只是进行简单的文本替换。而 `const` 定义的常量具有类型信息，编译器可以对其进行类型检查。这可以帮助捕获一些潜在的类型错误。
- 作用域：`#define` 定义的常量没有作用域限制，它在定义之后的整个代码中都有效。而 `const` 定义的常量具有块级作用域，只在其定义所在的作用域内有效。
- 调试和符号表：使用 `#define` 定义的常量在符号表中不会有相应的条目，因为它只是进行文本替换。而使用 `const` 定义的常量会在符号表中有相应的条目，有助于调试和可读性。



#### 键盘录入

> scanf

```c
//在使用之前需要加
#define _CRT_SECURE_NO_WARNINGS
scanf("%d", &a);
```



#### 存储类

存储类定义 C 程序中变量/函数的存储位置、生命周期和作用域。

这些说明符放置在它们所修饰的类型之前。

下面列出 C 程序中可用的存储类：

- auto
- register
- static
- extern

##### auto存储类

auto 存储类是所有**局部变量** **默认**的存储类。

定义在函数中的变量默认为 auto 存储类，这意味着它们在函数开始时被创建，在函数结束时被销毁。

auto 只能用在函数内，即 auto 只能修饰局部变量。

##### register 存储类

register 存储类用于定义**存储在寄存器**中而不是 RAM 中的局部变量。这意味着变量的最大尺寸等于寄存器的大小（通常是一个字），且不能对它应用一元的 '&' 运算符（因为它没有内存位置）。

register 存储类定义存储在寄存器，所以变量的访问速度更快，但是它不能直接取地址，因为它不是存储在 RAM 中的。在需要频繁访问的变量上使用 register 存储类可以提高程序的运行速度。

> ChatGpt：在现代编译器和计算机体系结构下，`register` 存储器的使用通常是不必要的

##### static存储类

###### 函数内部声明

在函数内部声明的变量使用 `static` 关键字时，表示该变量的生命周期为整个程序运行期间，但作用域仅限于声明它的函数内部。这意味着该变量在每次函数调用时不会重新创建，而是保留上一次调用时的值。这样的变量通常被称为静态局部变量。

```C
#include<stdio.h>

void func()
{
	static int a = 0;
	int b = 0;
	b++;
	a++;
	printf("a = %d \n", a);
	printf("b = %d \n", b);
}

int main()
{
	func();
	func();
	func();

	return 0;
}

//输出
a = 1 
b = 1 
a = 2 
b = 1 
a = 3 
b = 1
```

###### 文件内声明

在函数外部或者全局范围内使用 `static` 关键字来声明变量时，该变量的**作用域被限制在当前文件内部**。这意味着其他文件无法访问这个变量，即使它们使用了相同的变量名。这样的变量通常被称为静态全局变量。

###### 声明函数

在函数声明中使用 `static` 关键字表示该函数的作用域被限制在当前文件内部，其他文件无法访问该函数。这样的函数通常被称为**静态函数**。

##### extern存储类

extern 存储类用于定义在其他文件中声明的**全局变量或函数**。当使用 extern 关键字时，不会为变量分配任何存储空间，而只是指示编译器该变量在其他文件中定义。

extern 存储类用于提供一个**全局变量的引用**，**全局变量对所有的程序文件都是可见**的。当您使用 extern 时，对于无法初始化的变量，会把变量名指向一个之前定义过的存储位置。

当您有多个文件且定义了一个可以在其他文件中使用的全局变量或函数时，可以在其他文件中使用 *extern* 来得到已定义的变量或函数的引用。可以这么理解，*extern* 是用来在另一个文件中声明一个全局变量或函数。

#### 

#### 运算符

##### 位运算

假设变量 **A** 的值为 60，变量 **B** 的值为 13，则：

A = 0011 1100

B = 0000 1101

| 算符 | 描述                                                         | 实例                                                         |
| :--: | :----------------------------------------------------------- | :----------------------------------------------------------- |
|  &   | 对两个操作数的每一位执行**逻辑与**操作，如果两个相应的位都为 1，则结果为 1，否则为 0。按位与操作，按二进制位进行"与"运算。运算规则：`0&0=0;    0&1=0;     1&0=0;      1&1=1;` | (A & B) 将得到 12，即为 0000 1100                            |
|  \|  | 对两个操作数的每一位执行**逻辑或**操作，如果两个相应的位都为 0，则结果为 0，否则为 1。按位或运算符，按二进制位进行"或"运算。运算规则：`0|0=0;    0|1=1;    1|0=1;     1|1=1;` | (A \| B) 将得到 61，即为 0011 1101                           |
|  ^   | 对两个操作数的每一位执行**逻辑异或**操作，如果两个相应的位值相同，则结果为 0，否则为 1。异或运算符，按二进制位进行"异或"运算。运算规则：`0^0=0;    0^1=1;    1^0=1;   1^1=0;` | (A ^ B) 将得到 49，即为 0011 0001                            |
|  ~   | 对操作数的每一位执行**逻辑取反**操作，即将每一位的 0 变为 1，1 变为 0。取反运算符，按二进制位进行"取反"运算。运算规则：`~1=-2;    ~0=-1;` | (~A ) 将得到 -61，即为 1100 0011，一个有符号二进制数的补码形式。 |
|  <<  | 将操作数的所有位向**左移动指定的位数**。**左移 n 位相当于乘以 2 的 n 次方**。二进制左移运算符。将一个运算对象的各二进制位全部左移若干位（左边的二进制位丢弃，右边补0）。 | A << 2 将得到 240，即为 1111 0000                            |
|  >>  | 将操作数的所有位**向右移动指定的位数**。**右移n位相当于除以 2 的 n 次方**。二进制右移运算符。将一个数的各二进制位全部右移若干位，正数左补 0，负数左补 1，右边丢弃。 | A >> 2 将得到 15，即为 0000 1111                             |

##### 杂项运算

|  运算符  | 描述             | 实例                                 |
| :------: | :--------------- | :----------------------------------- |
| sizeof() | 返回变量的大小。 | sizeof(a) 将返回 4，其中 a 是整数。  |
|    &     | 返回变量的地址。 | &a; 将给出变量的实际地址。           |
|    *     | 指向一个变量。   | *a; 将指向一个变量。                 |
|   ? :    | 条件表达式       | 如果条件为真 ? 则值为 X : 否则值为 Y |



#### 函数

C语言在调用函数之前要对函数进行声明。

```C
#include<stdio.h>

int max(int, int);

int main()
{
	int max_value = max(10, 9);
	printf("max: %d \n", max_value);
	return 0;
}	

int max(int a, int b)
{
	if (a > b) {
		return a;
	} else {
		return b;
	}
	
}
```



#### 数组

##### 数组长度

> sizeof计算数组的内存大小，再除以每个元素的内存大小，就是有多少个元素

```C
int length = sizeof(numbers) / sizeof(numbers[0]);
```

##### 数组地址

在 C 语言中，数组名表示数组的地址，即数组首元素的地址。当我们在声明和定义一个数组时，该数组名就代表着该数组的地址。

```C
#include<stdio.h>

int main()
{
	double array[] = {2,4,6,8,100};
	printf("array: %p \n", array);
	printf("array: %p \n", &array[0]);
	return 0;
}	
//输出
array: 0x7fffca5d54e0 
array: 0x7fffca5d54e0
```

数组名在大多数情况下会被隐式转换为指向数组第一个元素的指针



#### 枚举

C语言的枚举第一个默认为0，后一个是前一个的+1。

##### 特点

1. **整数值**：在C语言中，枚举常量实际上是整数，可以进行整数运算。
2. **作用范围**：枚举类型的作用范围是全局的，如果在函数外定义，则作用域为整个文件。
3. **类型安全性较弱**：C语言的枚举类型实际上是整数类型，可以与其他整数混用，这可能导致类型安全问题。

##### 使用

```C
#include <stdio.h>

enum DAY
{
	red,
	green,
	blue = 4,
	pink
};

int main()
{
	enum DAY day;

	printf("day: %d \n", day); //输出任意int值
	day = red;
	printf("day: %d \n", day); //输出0

	return 0;
}
```

> 如果是连续的枚举，可以遍历，不连续则不可以遍历。



#### 指针

##### 定义

保存变量的内存地址，类型和变量一致。

##### 使用

```C
int a = 10;
int *ptr_a = NULL;
int *ptr_a = &a;
```

##### 空/非空指针

if(!prt_a) 表示空指针，反之表示非空。

> 理解：指针有内容为true，没有内容（NULL/0）为false。

##### 指针运算

###### 算术运算

递增/递减

> 根据指针类型，移动到下一个/上一个内存位置，比如int型，1000地址的下一个是1004。

比较

> 主要用于确定两个指针是否指向相同的内存位置或确定一个指针是否位于另一个指针之前或之后。

##### 函数指针





#### Makefile

在命令前要有制表符，空格不行。

> make -f AddMakeFile执行makefile文件

```makefile
#AddMakeFile
add:main.o add.o
	gcc -o add main.o add.o

main.o:main.c
	gcc -c main.c

add.o:add.c
	gcc -c add.c
```

