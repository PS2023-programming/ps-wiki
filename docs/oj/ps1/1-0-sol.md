# OJ 1-0 题解

**提交代码时 OJ 提交语言请选择C++**

### a+b problem

```c++
#include <bits/stdc++.h> // 万能头文件，推荐使用，仅include这一个即可; 写代码钱一定要记得添加头文件！
using namespace std; // std命名空间，现阶段推荐加上
// 如果不加，例如需要下面标程中的min函数，那么就要改成std::min; max, cin, cout, swap等同理
int main() // OJ 程序一定要有main函数！
{
    int a, b;
    scanf("%d %d", &a, &b);
    printf("%d", a + b);
    return 0;
}
```

### max&min problem

分支结构：

```c++
#include <bits/stdc++.h>
using namespace std;
int main()
{
	scanf("%d %d", &a, &b);
	if (a < b) 
		printf("%d %d", a, b);
	else 
		printf("%d %d", b, a);
	return 0;
}
```

``max``，``min``函数：

```c++
#include <bits/stdc++.h>
using namespace std;
int main()
{
	scanf("%d %d", &a, &b);
	printf("%d %d", min(a, b), max(a, b));
	return 0;
}
```

``swap``函数：

```c++
#include <bits/stdc++.h>
using namespace std;
int main()
{
	scanf("%d %d", &a, &b);
	if (a > b)
		swap(a, b);
	printf("%d %d", a, b);
	return 0;
}
```