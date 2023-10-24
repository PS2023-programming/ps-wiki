# OJ 1-5 题解

### T1

```c++
#include <bits/stdc++.h>
using namespace std;
int n;
string pll[5], blk[15], st;
void Move(int no, int st, int des, int mid)
{
	if (!no) return ;
	Move(no - 1, st, mid, des);
	printf("Move %s from %s to %s.\n", blk[no].c_str(), pll[st].c_str(), pll[des].c_str());
	Move(no - 1, mid, des, st);
}
int main()
{
	scanf("%d", &n);
	getline(cin, st); // 读掉行尾的回车
	for (int i = 1; i <= 3; i++)
		getline(cin, pll[i]);
	for (int i = 1; i <= n; i++)
		getline(cin, blk[n - i + 1]);
	Move(n, 1, 2, 3);
	return 0;
}
```
没什么好说的，主要就是要善用getline()

### T2

```c++
#include <bits/stdc++.h>
#define MAXN 1005
#define MAXK 100005
using namespace std;
struct node
{
    int no = 0;
    struct node *relNode = NULL; // for links, bottom node; for hangers upper node.
};
int n, m, K;
int op, x, y;
node *hangers[MAXN], *links[MAXN];
node *Find(node *x)
{
    while (x->no == 0) x = x->relNode;
    return x;
}
int main()
{
    scanf("%d %d %d", &n, &m, &K);
    for (int i = 1; i <= n; i++) {
        links[i] = new(node);
        links[i]->no = i;
        links[i]->relNode = links[i];
    }
    while (K--) {
        scanf("%d", &op);
        if (!op) {
            scanf("%d %d", &x, &y);
            if (hangers[x] == NULL) {
                hangers[x] = new(node);
                hangers[x]->relNode = links[y]->relNode;
                links[y]->relNode = hangers[x];
            }
            else {
                node *fa = Find(hangers[x]);
                node *tmp = fa->relNode;
                fa->relNode = hangers[x]->relNode;
                hangers[x]->relNode = links[y]->relNode;
                links[y]->relNode = tmp;
            }
        }
        else {
            scanf("%d", &x);
            if (hangers[x] != NULL)
                printf("%d\n", Find(hangers[x])->no);
            else printf("free hanger.\n");
        }
    }
    return 0;
}
```

我是用链表写的，将衣架和挂钩节点都用node表示。对于衣架节点，relNode为其上方的节点（可能是衣架或者是挂钩）；对于挂钩节点，其relNode为下方最下面的衣架结点（若下方没有衣架，则为它自己）。维护这样一个结构即可。

### T3

```c++
#include <bits/stdc++.h>
#define MAXN 5005
using namespace std;
int n, a[MAXN], ans;
int main()
{
	scanf("%d", &n);
	for (int i = 1; i <= n; i++) scanf("%d", &a[i]);
	for (int i = 1; i < n; i++)
		for (int j = 1; j <= n - i; j++)
			if (a[j] > a[j + 1]) {
				swap(a[j], a[j + 1]);
				ans++;
			}
	for (int i = 1; i <= n; i++) printf("%d ", a[i]);
	printf("\n%d", ans);
	return 0;
}
```