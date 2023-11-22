# OJ 1-6 题解

## 非暴力不合作（超级弱化版）

注意到如果对于每次吃，晚吃是不如早吃的。因为早吃的收益和晚吃一样，但是早吃可以更早的获得收益，在任何情况下都比晚吃好，证明留给读者。

所以如果我们选择吃 $u$ 次，那必然是前 $u$ 天选择吃。于是我们枚举这个 $u$。

记前 $u$ 天的食物和为 $S_u$，$u$ 能使得抗议活动成功当且仅当：

$$
S_u \geq   nk + D - s_0 \wedge  \forall i \in [u], S_i \geq ik + D - s_0 
$$

后一个条件和 $u$ 无关，如果它不成立则题目无解。

标程列下（$\text{pac}$）：

```cpp
#include <bits/stdc++.h>
using namespace std;

const int MN = 1e5 + 5;
int a[MN], n, d, k;
long long s0;
int main() {
    ios::sync_with_stdio(0);
    cin.tie(0);
    cin >> s0 >> k >> d >> n;
    int N = n;
    int ans = 0;
    for (int i = 1; i <= n; ++i) {
        cin >> a[i];
    }
    while (s0 - 1ll * k * n < d) {
        ++ans;
        --n;
        if (ans > N)
            break;
        s0 -= k;
        s0 += a[ans];
        if (s0 < d) {
            ans = N + 1;
            break;
        }
    }
    ans = N - ans;
    cout << ans << "\n";
    return 0;
}
```

## 内卷（弱化版）

考虑维护 $a_i \leq a_{i+1}, i \in [n-1]$ 的 $i$ 的数量 $k$。

形式化地，写作：

$$
k = \sum_{i \in [n-1]} f(i) = \sum_{i \in [n-1]} \mathbb{I}(a_i \leq a_{i+1})
$$

容易知道，数组不降当且仅当 $k = n - 1$。

对于操作开始前的 $k$，可以边输入序列边算好。

此后进行每次修改 $d$ 位置的操作，我们发现只有 $f(d)$ 和 $f(d+1)$ 可能发生变化，那我们此时维护 $k$ 即可。形式化地，写作：

$$
k \gets k' - f'(d) - f'(d+1) + f(d) + f(d+1)
$$

标程列下（$\text{Bardisk}$）：

```cpp
#include <cstdio>
int a[200005], b[200005];
int cnt = 0;
int main() {
    int n, m;
    scanf("%d %d", &n, &m);
    for (int i = 1; i <= n; i++) {
        scanf("%d", &a[i]);
        if (i > 1 && a[i] < a[i - 1])
            cnt++;
    }
    for (int i = 1; i <= m; i++) {
        int b, s;
        scanf("%d %d", &b, &s);
        if (b > 1 && a[b] < a[b - 1])
            cnt--;
        if (b < n && a[b] > a[b + 1])
            cnt--;
        a[b] = s;
        if (b > 1 && a[b] < a[b - 1])
            cnt++;
        if (b < n && a[b] > a[b + 1])
            cnt++;
        puts(cnt == 0 ? "YES" : "NO");
    }
}
```

## 追忆逝水年华

模拟题，做法如题意。

标程列下（$\text{pac}$）：

```cpp
#include <bits/stdc++.h>
using namespace std;

long long a[1005][1005], b[10][10];
bool c[10][10];

int main() {
    int n, m;
    ios::sync_with_stdio(0);
    cin.tie(0);
    cin >> n >> m;
    int nn = n / 8, mm = m / 9;
    for (int i = 1; i <= n; ++i)
        for (int j = 1; j <= m; ++j) {
            cin >> a[i][j];
            b[(i - 1) / nn + 1][(j - 1) / mm + 1] += a[i][j];
        }
    for (int i = 1; i <= 8; ++i)
        for (int j = 1; j <= 9; ++j) b[i][j] /= (nn * mm);
    for (int i = 1; i <= 8; ++i)
        for (int j = 1; j <= 8; ++j) c[i][j] = b[i][j + 1] > b[i][j];
    for (int i = 1; i <= 8; ++i) {
        for (int j = 1; j <= 8; j += 4) {
            int num = (c[i][j] << 3) + (c[i][j + 1] << 2) + (c[i][j + 2] << 1) + (c[i][j + 3]);
            if (num < 10)
                cout << num;
            else
                cout << (char)('A' + num - 10);
        }
    }
    return 0;
}
```