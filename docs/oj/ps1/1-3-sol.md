# OJ 1-3 题解

### T1

```c++
#include <bits/stdc++.h>
#define ll long long
using namespace std;
int n, k;
int a[105];
void print()
{
    for (int i = 1; i <= k; i++)
        printf("%d ", a[i]);
    printf("\n");
}
void calc(int sum, int d, int pre)
{
    if (d == k) {
        if (sum >= pre) {
            a[d] = sum;
            print();
        }
        return ;
    }
    for (int i = pre; i <= sum; i++) {
        a[d] = i;
        calc(sum - i, d + 1, i);
    }
    return ;
}
int main()
{
    scanf("%d %d", &n, &k);
    if (n < k) {
        printf("Invalid\n"); // "Invalid"!!!
        return 0;
    }
    calc(n, 1, 1);
    return 0;
}
```

几个注意的地方：

1. 递归中``for``循环从``pre``开始，保证生成答案中的数字单调不减；
2. 最后一个数直接设定为剩余值（即``sum``），同时判断单调不减；
3. 虽然"Invalid"的情况在题目中的意思是没有解，但这并不是程序的**"error"**，请不要写出类似``return 1;``的代码。

这些方法都是递归**剪枝**的常用技巧，所谓**剪枝**就是减少对于递归中无用的冗余状态的探索（一次递归深入产生一个状态，这种结构很像数据结构中的“树”结构），从而减少递归次数与计算时间。

### T2

```c++
#include <bits/stdc++.h>
using namespace std;
string S, t;
int m;
int count(int l, int r, string t)
{
	int num = 0;
	for (int i = l; i <= r; i++) {
		int tlen = t.length(); // When using "char[]", it's a must; However, for "string", the time for calculate t.length() is actually O(1), so it's actually not essential.
		if (i + tlen - 1 <= r) {
			bool flag = 1;
			for (int len = 0; len < tlen; len++)
				if (t[len] != S[i + len]) {
					flag = 0;
					break;
				}
			if (flag) num++;
		}
	}
	return num;
}
int main()
{
	cin >> S >> m;
	int l, r;
	for (int i = 1; i <= m; i++) {
		cin >> l >> r >> t; // you can also use "scanf", "getline", etc.
		printf("%d\n", count(l - 1, r - 1, t));
	}
	return 0;
}
```

### T3

```c++
#include <bits/stdc++.h>
#define MAXN 25
using namespace std;
int n, m, K;
int x[MAXN][MAXN], y[MAXN][MAXN]; // Array y is for transformation.
int op, a, b; // op stands for "operation", not a group of gamers.
void copyBack() // copy y to x
{
	for (int i = 1; i <= n; i++)
		for (int j = 1; j <= m; j++)
			x[i][j] = y[i][j];
}
void print() // print x
{
	for (int i = 1; i <= n; i++) {
		for (int j = 1; j <= m; j++)
			printf("%d ", x[i][j]);
		printf("\n");
	}
}
bool check(int a, int b, int maxn) // check if valid
{
	return a > 0 && b > 0 && a <= maxn && b <= maxn;
}
int main()
{
	scanf("%d %d %d", &n, &m, &K);
	for (int i = 1; i <= n; i++)
		for (int j = 1; j <= m; j++)
			scanf("%d", &x[i][j]);
	while (K--) {
		scanf("%d", &op);
		if (op != 3) scanf("%d %d", &a, &b);
		bool valid = 1;
		if (op == 1) {
			if (!check(a, b, n)) valid = 0;
			else 
				for (int j = 1; j <= m; j++)
					swap(x[a][j], x[b][j]);
		}
		else if (op == 2) {
			if (!check(a, b, m)) valid = 0;
			else 
				for (int i = 1; i <= n; i++)
					swap(x[i][a], x[i][b]);
		}
		else {
			for (int i = 1; i <= m; i++)
				for (int j = 1; j <= n; j++)
					y[i][j] = x[n - j + 1][i];
			swap(n, m); // simply swap(n, m), no need to use something like "isHorizontal"
			copyBack();
		}
		if (valid) print();
		else 
			printf("Invalid arguments!\n");
	}
	return 0;
}
```