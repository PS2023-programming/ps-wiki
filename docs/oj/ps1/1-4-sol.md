# OJ 1-4 题解

### T1

```c++
#include <bits/stdc++.h>
#define MAXN 100005
using namespace std;
int n, m, num_yu[MAXN], num_sh[MAXN], k;
void write()
{
    for (int i = 1; i <= k; i++)
    {
        printf("%d", num_sh[i]);
    }
}
void writeln()
{
    for (int i = 1; i < num_yu[n]; i++)
    {
        printf("%d", num_sh[i]);
    }
    printf("(");
    for (int i = num_yu[n]; i <= k; i++)
    {
        printf("%d", num_sh[i]);
    }
    printf(")");
}
int main()
{
	scanf("%d%d", &n, &m);
    if (n % m == 0)
    {
        printf("%d.0", n / m);
        return 0;
    }
    printf("%d.", n / m);
    n %= m;
    num_yu[n] = 1;
    while (n) {
        n *= 10;
        num_sh[++k] = n / m;
        n %= m;
        if (num_yu[n]) {
            writeln();
            return 0;
        }
        num_yu[n] = k + 1;
    }
    write();
    return 0;
}
```

在本题中，很多同学没有注意到在一开始的时候，余数``n % m``就是要被记录的：如1/3的时候，第一次记录的余数应该就是``1 % 3``本身，而非是``(1 * 10) % 3``。

### T2

```c++
#include <bits/stdc++.h>
#define ll long long
#define MAXN 1000005
using namespace std;
int n, R, a, c;
int x[MAXN], d[MAXN];
int psh, pll;
double x0;
int m;
int l, r;

int main()
{
    scanf("%d %d %d %d", &n, &R, &a, &c);
    for (int i = 1; i <= n; i++) scanf("%d", &d[i]);
    for (int i = 1; i <= n; i++) scanf("%d", &x[i]);

    double loc = sqrt((double)c / (-a));
    for (int i = 1; i <= n; i++) {
        if ((double)x[i] <= loc + R && x[i] >= R && a * (x[i] - R) * (x[i] - R) + c < d[i]) {
            psh = i;
            break;
        }
    }

    for (int i = 1; i <= n; i++) {
        if ((double)x[i] <= loc - R && a * (x[i] + R) * (x[i] + R) + c < d[i]) {
            pll = i;
            break;
        }
    }

    if (!psh && !pll) {
        l = ceil(sqrt((double)c / (-a)) - R);
        r = ceil(sqrt((double)c / (-a)) + R);
        x0 = sqrt((double)c / (-a));
    }
    else if (psh && !pll) {
        l = x[psh] - 2 * R;
        r = x[psh];
        x0 = l + R;
    }
    else if (!psh && pll) {
        l = x[pll];
        r = x[pll] + 2 * R;
        x0 = l + R;
    }
    else {
        int xa = x[psh] - R, xb = x[pll] + R;
        l = min(xa, xb) - R;
        r = min(xa, xb) + R;
        x0 = l + R;
    }

    for (int i = 1; i <= n; i++) 
        if (x[i] >= l && x[i] < r) m++;
    
    printf("%.3lf %d\n", x0, m);
    return 0;
}
```

本题的思路就是对"push"和"pull"两种情况分开讨论圈会在什么时候被停下，然后对比哪个更考前即可。细节方面的注意点就是类型转换的问题。

注意，如果你只对**未落地**位置的$x$计算$ax^2+c$的话，显然有该值是在 int 范围内的——事实上你也只需要对未落地位置的$x$计算二次函数的值。

### T3

```c++
#include <bits/stdc++.h>
#define ll long long
#define MAXN 1000005
using namespace std;
int n, k;
ll calc(int x)
{
    if (!x) return 0;
    return calc(sqrt(x) / k) + calc(sqrt(x) / (2 * k)) + x / 2;
}
int main()
{
    scanf("%d %d", &n, &k);
    printf("%lld", calc(n));
    return 0;
}
```