# OJ 1-1题解

### Equation

参考代码：

```c++
#include <bits/stdc++.h>
#define eps 1e-8
#define ll long long
using namespace std;
int main()
{
    int a, b, c;
    scanf("%d %d %d", &a, &b, &c);
    ll delta = (ll)b * b - 4 * (ll)a * c;
    if (delta > 0) {
        printf("2\n");
        double xa = (double)(-b + sqrt((double)delta)) / (2 * a);
        double xb = (double)(-b - sqrt((double)delta)) / (2 * a);
        printf("%.3lf %.3lf\n", xa, xb);
    }
    else if (delta == 0) {
        double x = (double)(-b) / (2 * a);
        printf("1\n");
        printf("%.3lf\n", x);
    }
    else printf("0\n");
    return 0;
}
```

注意：``include <bits/stdc++.h>``为万能头文件，其中包括了大多 OJ 题中需要使用的 c++ 头文件，可以参考使用；

``scanf``中``%d``之间是否要有空格视代码习惯而定，可有可没有；

``printf``中``%.3lf``表示保留三位小数，推荐用这种方法保留小数，比较简洁；

``#define ll long long``与``typedef long long ll;``等价，在如此声明之后，接下来的代码中就可以用``ll``代替``long long``使用，更加便捷（没有推销自己的意思）。

### Coin

参考代码：

```c++
#include <bits/stdc++.h>
using namespace std;
int main()
{
    int a, b, c;
    scanf("%d %d %d", &a, &b, &c);
    printf("%d", 25 * a + 10 * b + 5 * c);
    return 0;
}
```

### Load

参考代码：

```c++
#include <bits/stdc++.h>
#define ll long long
using namespace std;
int n, T, W;
ll ans, tot, used;
int main()
{
    scanf("%d %d %d", &n, &T, &W);
    tot = W;
    int t, w, v;
    for (int i = 1; i <= n; i++) {
        scanf("%d %d %d", &t, &w, &v);
        tot = (ll)(1 + t / T) * W;
        if ((ll)w <= tot - used) {
            used += (ll)w;
            ans += (ll)w * v;
        }
        else {
            ans += (tot - used) * (ll)v;
            used = tot;
        }
    }
    printf("%lld", ans);
    return 0;
}
```

注意，``t / T``中两个 int 类型整数相除默认向下取整。

本题不需要使用数组。