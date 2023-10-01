# OJ 1-2 题解

如果你在写 OJ 的过程中遇到了困难，那么即使你最后通过了 OJ 测试，我们也建议你看一看题解。也许是你写的代码太过复杂，导致 debug 的难度骤升。在题解中你可以学到一些简洁的做法。

### Game

参考代码：

```c++
#include <bits/stdc++.h>
#define ll long long
#define MAXN 10005
using namespace std;
int n, a[MAXN];
bool vis[MAXN];
int main()
{
    scanf("%d", &n);
    for (int i = 1; i <= n; i++) scanf("%d", &a[i]);
    int now = 1, mov = 0;
    for (int i = 1; i < n; i++) {
        while (mov) {
            now++;
            if (now > n) now = 1; // attention here
            if (!vis[now]) mov--;
        }
        vis[now] = 1;
        mov = a[now];
    }
    for (int i = 1; i <= n; i++) 
        if (!vis[i]) {
            printf("%d\n", i);
            break;
        }
    return 0;
}
```

注意：使用注释所在行的方法可以在本题中避免使用模运算——模运算是非常耗时、非常慢的。

部分同学的代码写的非常复杂，其实这里只需要一个``for``循环和一个``while``循环嵌套就好了。代码的关键部分就是在“模拟”题目中给出的过程，“模拟”的思想是本学期 OJ 部分最重要的思想。

### String

参考代码：

```c++
#include <bits/stdc++.h>
#define MAXN 100005
using namespace std;
char T[MAXN], st[MAXN];
int main()
{
    scanf("%s", T);
    int len = strlen(T);
    int now = 0;
    while (now < len) {
        strcpy(st, "");
        int nowlen = 0;
        while (T[now] >= 'a' && T[now] <= 'z') { // or use isdigit()
            st[nowlen++] = T[now];
            now++;
        }
        st[nowlen] = '\0'; // attention here
        int num = T[now++] - '0';
        for (int i = 1; i <= num; i++) printf("%s", st);
    }
    return 0;
}
```

注意：一个字符串总是以'\0'作为结尾的标识符（其实就是ASCII码的0），因此在手动用向字符数组对应下标位置赋值的方法构造一个字符串后，要习惯性地在末尾添上一个'\0'（否则机器不知道字符串应该到哪里终止）；

另外，正如题目中所标注的，用``len = strlen(T)``来记录字符串$T$的长度是一个好习惯。

### Food

参考代码：

```c++
#include <bits/stdc++.h>
using namespace std;
int main()
{
    int c, b, a, y;
    cin >> c >> b >> a >> y;
    if ((c || b) && a) {
        if (!y) {
            cout << 0;
            return 0;
        }
    }
    cout << 1;
    return 0;
}
```

在 OJ 中，无论输出结果是“是”还是“否”，都要以``return 0;``作为结尾，表示主函数正常运行并退出。千万不要以为"invalid"的情况就是要``return 1;``啊。