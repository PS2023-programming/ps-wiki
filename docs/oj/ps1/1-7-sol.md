# OJ 1-7 题解

## 非暴力不合作（特别弱化版）

注意到对于任何一天 $i$ ，我们都可以计算在这天吃食物的收益，即 $a_i + b_i$，记为 $r_i$。

记前 $i$ 天的困难度之和减去 $D$ 加上 $s_0$ 为 $S_i$。

对于前 $i$ 天，我们选择吃的 $k$ 天（记此集合为 $K_i$）需要满足 $\forall d \in [i], \sum_{j \in K_d} r_j + S_d \geq 0$，并使得 $k$ 最小。

容易想到一个策略：对于前 $i$ 天，我们同样首先选择前 $i-1$ 天选择的集合 $K_{i-1}$，然后再选择前 $i$ 天其他未选择且收益值最大的，使得 $\sum_{j \in K_i} r_j + S_i \geq 0$。

<!-- 我们很可以证明这个方法是对的。

$i = 1$ 时显然。

对于任意 $i > 1$，考虑一个更优秀的 $K'_i$，有 $|K_i| > |K'_i|$。

首先如果 $K_{i-1} \subseteq K'_i$，则容易导出矛盾。

选出 $K'_i$ 的一个最小子集 $K'_{i-1}$ 使得其可以满足前 $i-1$ 天的限制条件，我们知道 $|K'_{i-1}| \geq |K_{i-1}|$，于是 $|K'_{i}\setminus K'_{i-1}| < |K_{i} \setminus K_{i-1}|$。
记 $D = K'_i \setminus K_{i-1}$

*（这种性质叫做最优子结构）* -->


标程列下（$\text{pac}$）：

```cpp
#include <bits/stdc++.h>
using namespace std;
typedef long long ll;

const int N = 1e5 + 3;
int n, s0, d, a[N], b[N];
int main() {
    cin >> s0 >> d >> n;
    for (int i = 1; i <= n; ++i) cin >> a[i];
    for (int i = 1; i <= n; ++i) cin >> b[i];
    priority_queue<int> pq;
    int ans = 0, now = 0;
    for (int i = 1; i <= n; ++i) {
        pq.push(a[i] + b[i]);
        s0 -= b[i];
        ++now;
        while (s0 < d) {
            if (pq.empty()) {
                cout << "-1\n";
                return 0;
            }
            s0 += pq.top();
            pq.pop();
            --now;
        }
        ans = max(ans, now);
    }
    cout << ans << '\n';
}
```

## 「Hack」OJ 1-7

为第一天提供恰巧能把状态打到下限的困难度和足以完全通过整个抗议活动的食物值。

正确做法只需要在第一天吃，而错误解法第一天不会选择吃，只能在后面每天都吃。

标程列下（$\text{Bardisk}$）：

```cpp
#include <cstdio>
int n;
int main() {
    scanf("%d", &n);
    printf("%d %d %d\n", 1000, 0, n);

    printf("%d 0 0", n + 100000);
    for (int i = 4; i <= n; i++) {
        printf(" 0");
    }
    puts("");

    printf("1000 1 1");
    for (int i = 4; i <= n; i++) {
        printf(" 1");
    }

    return 0;
}
```

## 异星工厂-运算器（超级弱化版）

栈的做法如题意。

递归做法假设 $\text{work}(s, l)$ 为以 $s$ 为起始，包含的所有双目运算符优先级均超过 $l$ 的表达式的值。

然后就可以不断规约了，假设目前看到的符号后一位为 $x$：

+ 单目运算符优先级最高且只会出现在开头，可以立即处理。
+ 遇到比阈值低优先级的双目运算符就返回。
+ 遇到优先级 $l'$ 相同或较高的双目运算符可以立即递归计算右边表达式的值 $\text{work}(x, l')$。
+ 遇到左括号使用 $\text{work}(x, -1)$，遇到右括号立即返回。

具体详见代码，细节不论。

标程列下（$\text{Bardisk}$，使用递归）：

```cpp
#include<cstdio>
const char optr[7] = { '+','-','*','/','%','<','>' };
const int priority[7] = { 1,1,5,5,5,0,0 };
inline int findOptr(char s) {
	for (int i = 0; i < 7; i++)
		if (optr[i] == s) return i;
	return -1;
}
char expr[200005];
int end;
bool reSign;
int work(int start, int level) {
	int ans = 0;
	bool flag = false;
	for (;; start = end + 1) {
		if (reSign) return 0xffffffff;
		if (expr[start] <= '9' && expr[start] >= '0') {
			ans = expr[start] - '0', end = start;
		}
		if (~findOptr(expr[start]) || expr[start] == '~') {
			if (flag) {
				int now = findOptr(expr[start]);
				if (priority[now] <= level) { end = start - 1; break; }
				if (expr[start] == '+') ans = ans + work(start + 1, priority[now]);
				if (expr[start] == '-') ans = ans - work(start + 1, priority[now]);
				if (expr[start] == '*') ans = ans * work(start + 1, priority[now]);
				if (expr[start] == '/') {
					int tmp = work(start + 1, priority[now]);
					if (!tmp) {
						puts("Runtime Error");
						reSign = true;
						return 0xffffffff;
					}
					ans = ans / tmp;
				}
				if (expr[start] == '%') {
					int tmp = work(start + 1, priority[now]);
					if (!tmp) {
						puts("Runtime Error");
						reSign = true;
						return 0xffffffff;
					}
					ans = ans % tmp;
				}
				if (expr[start] == '<') ans = ans < work(start + 1, priority[now]);
				if (expr[start] == '>') ans = ans > work(start + 1, priority[now]);
			}
			else {
				if (expr[start] == '+') ans = +work(start + 1, 8);
				if (expr[start] == '-') ans = -work(start + 1, 8);
				if (expr[start] == '~') ans = ~work(start + 1, 8);
			}
		}
		if (expr[start] == '(') { ans = work(start + 1, -1); ++end; }
		if (expr[start] == ')') {
			end = start - 1; break;
		}
		if (expr[start] == '\0') {
			end = start - 1; break;
		}
		flag = true;
	}
	return ans;
}
int main() {
	int T;
	scanf("%d", &T);
	while (T--) {
		reSign = false;
		scanf("%s", expr);
		int tmp = work(0, -1);
		if (!reSign) printf("%d\n", tmp);
	}
	return 0;
}
```

（$\text{抑制「スーパーエゴ」}$，使用栈）：

```cpp
#include <bits/stdc++.h>
using namespace std;
#define N 262144

int n;
int prio2[128];
char expr[N];

struct elem {
    int o, v; // opt, val
    // 0: number
    // 1: unary operator
    // 2: binary operator
    // '(': left bracket
    // ')': right bracket
    elem() : o(-1), v() {}
    elem(int _o, int _v) : o(_o), v(_v) {}
    void print() {
        if (o == 0) printf("%d %d\n", o, v);
        else printf("%d \'%c\'\n", o, v);
    }
};
struct stack_elem {
    elem d[N], *t;
    void clear() { t = d; }
    bool push(elem x) { return *t++ = x, true; }
    bool pop(elem &x) {
        if (t == d) return false;
        return x = *--t, true;
    }
    bool pop() {
        if (t == d) return false;
        return --t, true;
    }
    bool empty() { return t == d; }
    unsigned int size() { return t - d; }
    void print() {
        puts(": {");
        for (elem *i = d; i != t; ++i) i->print();
        puts("}");
    }
} op, pf; // postfix formula

void work() {
    scanf("%s", expr);
    n = strlen(expr);
    op.clear(), pf.clear();

    int p_opt = -1;
    for (char *i = expr; *i != '\0'; ++i) {
        if (isdigit(*i)) {
            int v = *i - '0';
            while (isdigit(*(i + 1))) v = v * 10 + (*++i) - '0';
            pf.push(elem(0, v));
            assert(v < 10);
            p_opt = 0;
            continue;
        }

        if (*i == '(') {
            op.push(elem('(', '('));
            p_opt = '(';
        } else if (*i == ')') {
            elem x;
            while (!op.empty()) {
                op.pop(x);
                if (x.o == '(') break;
                pf.push(x);
            }
            p_opt = ')';
        } else {
            if (p_opt != 0 && p_opt != ')') {
                
                assert(*i == '+' || *i == '-' || *i == '~');
                op.push(elem(1, *i));
                p_opt = 1;
            } else {
                assert(*i == '*' || *i == '/' || *i == '%' ||
                       *i == '+' || *i == '-' ||
                       *i == '>' || *i == '<');
                elem x;
                while (!op.empty()) {
                    op.pop(x);
                    if (x.o == '(' || 
                        (x.o == 2 && prio2[x.v] > prio2[*i])) {
                        op.push(x);
                        break;
                    }

                    pf.push(x);
                }

                op.push(elem(2, *i));
                p_opt = 2;
            }
        }
    }

    while (!op.empty()) {
        elem x;
        op.pop(x);
        pf.push(x);
    }

    // ---------------------

    for (elem *x = pf.d; x != pf.t; ++x) {
        assert(0 <= x->o && x->o <= 2);

        if (x->o == 0) {
            op.push(*x);
        } else if (x->o == 1) {
            assert(!op.empty());

            elem j;
            op.pop(j);
            if (x->v == '-') {
                j.v = -j.v;
            } else if (x->v == '~') {
                j.v = ~j.v;
            }
            op.push(j);
        } else {
            assert(op.size() > 1);

            elem i, j, k;
            op.pop(j), op.pop(i);
            if (x->v == '<') {
                k = elem(0, i.v < j.v);
            } else if (x->v == '>') {
                k = elem(0, i.v > j.v);
            } else if (x->v == '+') {
                k = elem(0, i.v + j.v);
            } else if (x->v == '-') {
                k = elem(0, i.v - j.v);
            } else if (x->v == '*') {
                k = elem(0, i.v * j.v);
            } else if (x->v == '/') {
                if (j.v == 0) {
                    return puts("Runtime Error"), void();
                }
                k = elem(0, i.v / j.v);
            } else if (x->v == '%') {
                if (j.v == 0) {
                    return puts("Runtime Error"), void();
                }
                k = elem(0, i.v % j.v);
            }

            op.push(k);
        }
    }

    assert(op.size() == 1);
    elem res;
    op.pop(res);
    printf("%d\n", res.v);
}

int main() {
    prio2['*'] = prio2['/'] = prio2['%'] = 3;
    prio2['+'] = prio2['-'] = 4;
    prio2['>'] = prio2['<'] = 5;

    int T;
    scanf("%d", &T);
    while (T--) work();
    return 0;
}
```