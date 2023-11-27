### OJ 1-9 题解

#### T1

```c++
#include <cstdio>
#include <algorithm>

#define _R 20

int r;
int A[_R][_R];

int n, m, l;
int B[_R][_R], C[_R][_R];

long long D[_R][_R];

int p[_R];

int main() {
    scanf("%d", &r);
    for (int i = 1; i <= r; i++) {
        p[i] = i;
        for (int j = 1; j <= r; j++) {
            scanf("%d", &A[i][j]);
        }
    }
    scanf("%d%d%d", &n, &m, &l);
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            scanf("%d", &B[i][j]);
        }
    }
    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= l; j++) {
            scanf("%d", &C[i][j]);
        }
    }
    long long ans = 0;
    do {
        int cnt = 0;
        for (int j = 2; j <= r; j++) {
            for (int i = 1; i < j; i++) {
                if (p[i] > p[j]) {
                    cnt++;
                }
            }
        }
        long long prod = (cnt & 1) ? -1 : 1;
        for (int i = 1; i <= r; i++) {
            prod = prod * A[i][p[i]];
        }
        ans += prod;
    } while (std::next_permutation(p + 1, p + r + 1));
    printf("%lld\n", ans);
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= l; j++) {
            for (int k = 1; k <= m; k++) {
                D[i][j] += 1ll * B[i][k] * C[k][j];
            }
            printf("%lld ", D[i][j]);
        }
        puts("");
    }
    return 0;
}
```

代码填空，根据框架作答即可。

#### T2

```c++
#include <bits/stdc++.h>
using namespace std;
int att, n, q, t;
char op[5];
int main()
{
    scanf("%d %d", &n, &q);
    for (int i = 0; i < q; i++) att |= (1 << i);
    for (int i = 1; i <= n; i++) {
        scanf("%s %d", op, &t);
        if (strcmp(op, "AND") == 0) att &= t;
        if (strcmp(op, "OR") == 0) att |= t;
        if (strcmp(op, "XOR") == 0) att ^= t;
    }
    printf("%d\n", att);
    return 0;
}
```

（某种程度上的）思维题。你可以按位构造答案：当前位初始答案为1，若遇到&1操作，则答案不变；若遇到&0操作，答案可不变可取反（因为任意数&0均为0，“输入”的答案并不重要）；若遇到|0操作，则答案不变；若遇到|1操作，答案可不变可取反（理由同上）；若遇到^0操作，答案不变；若遇到^1操作，答案取反。

注意到在以上过程中，若对于&0操作，我们将答案也&0；对于|1操作，我们将答案也|1（因为“输入”的答案并不重要，因此任意操作不影响解的最优性），则整个过程变为生成一个全1的初始答案直接经过所有“门运算”的解，因此有题解中的方法。

#### T3

```c++
#include <bits/stdc++.h>
#define MAXN 1000005
using namespace std;
int n, m;
queue <int> Q;
int enterTime[MAXN];
int ans[MAXN];
bool vis[MAXN];
int main()
{
    scanf("%d %d", &n, &m);
    for (int i = 1; i <= n; i++) {
        int id;
        scanf("%d", &id);
        if (vis[id]) ;
        else if (Q.size() < m) {
            Q.push(id);
            vis[id] = 1;
            enterTime[id] = i;
        }
        else {
            int now = Q.front();
            Q.pop();
            vis[now] = 0;
            ans[now] += (long long)i - enterTime[now];
            Q.push(id);
            vis[id] = 1;
            enterTime[id] = i;
        }
    }
    while (!Q.empty()) {
        int now = Q.front();
        Q.pop();
        ans[now] += (long long)(n + 1) - enterTime[now];
    }
    for (int i = 1; i <= n; i++)
        if (ans[i]) {
            printf("%d %d\n", i, ans[i]);
        }
    return 0;
}
```

队列模拟即可，维护每个单词“最后一次”入队的时间，出队时用它更新ans。

注意，stl中已经实现了简单的队列（queue）和双端队列（deque），建议学习并使用。

类似的思想（即仅维护“入队时间”，ans出队的时候计算（或者不需要计算ans））在考试T2中也有涉及。具体见后续摸底测试的题解。