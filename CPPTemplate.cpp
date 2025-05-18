#include <bits/stdc++.h>
using namespace std;

#define tpl_ template
#define tn_ typename
#define cx_ constexpr
#define fn function
#define f(i, to) for (int i = 0; i < (to); ++i)
#define fe(i, to) for (int i = 1; i <= (to); ++i)
#define rep(i, a, b) for (int i = (a); i <= (b); ++i)
#define repr(i, a, b) for (int i = (a); i >= (b); --i)
#define ff first
#define ss second
#define pb push_back
#define fora(a, x) for (auto &a : x)
#define all(x) (x).begin(), (x).end()
#define rall(x) (x).rbegin(), (x).rend()
#define quit(s) do{ cout<<(s)<<en; return; }while(false)

#define int long long
tpl_<tn_ T>       using v = vector<T>; using ll=long long; using pii=pair<int,int>; using pll=pair<ll,ll>; using iii=array<int, 3>;  using i4=array<int, 4>;
tpl_<tn_ T>       using vv = v<v<T>>;  using vi=v<int>;    using vb=v<bool>; using vvb=v<vb>; using vs=v<string>;  using vvi=v<vi>; using vll=v<ll>; using vpii=v<pii>; using vvpii=v<vpii>;
tpl_<tn_ K,tn_ T> using ump=unordered_map<K, T>;  tpl_<tn_ T>using ust=unordered_set<T>; tpl_<tn_ T> using rset=set<T,greater<T>>; tpl_<tn_ T> using mset=multiset<T>;
tpl_<tn_ T>       using pq=priority_queue<T>;     tpl_<tn_ T>using mpq=priority_queue<T,v<T>,greater<T>>;
tpl_<class It, class T>     auto leq_bound  (It first, It last, T val) { auto it = upper_bound(first, last, val); return it != first ? prev(it) : last;}
tpl_<class It, class T>     auto less_bound (It first, It last, T val) {auto it = lower_bound(first, last, val);return it != first ? prev(it) : last; }
using str = string; typedef fn<void(int, int, int)> fviii;  typedef fn<void(int, int)> fvii; typedef fn<void(int)> fvi;
auto ad = [](int a, int b) {return a+b;}; auto sub = [](int a, int b) {return a-b;}; auto sortinv = [](const pii& a,const pii& b) {if(a.ff == b.ff) return a.ss > b.ss; return a.ff < b.ff;};

void setIO(const str &name = "") {ios_base::sync_with_stdio(false); cin.tie(nullptr); if (!name.empty()) { freopen((name + ".in").c_str(), "r", stdin); freopen((name + ".out").c_str(), "w", stdout); }}
tpl_<tn_ A, tn_ B> ostream& operator<<(ostream& os, const pair<A, B>& p){ return os<<"("<<p.ff<<", "<<p.ss<<")";}
tpl_<tn_ A> ostream&        operator<<(ostream& os, const v<v<A>>& v)   { for (const auto& row : v) { os << "{ "; for (const auto& elem : row) {os<<elem<<" ";}os<<"}"; os<<"\n";} return os;}
tpl_<tn_ K, tn_ T> ostream& operator<<(ostream& os, const map<K, T>& m) { os << "{"; str sep; for (const auto& kv : m) os << sep << kv.ff << ": " << kv.ss, sep = ", "; return os << "}"; }
tpl_<tn_ C, tn_ T = enable_if_t<!is_same_v<C, str>, typename C::value_type>> ostream& operator<<(ostream& os, const C& v) { os<<"{"; str sep; for(const T& x : v) os<<sep<<x, sep=", "; return os<<"}";}
struct cind{template<typename T> cind& operator>>(T &x){cin>>x;--x;return *this;}} cind;
struct bout{tpl_<tn_ T> bout& operator<<(T x){if cx_(is_integral_v<T>){int y=x;if(y==0){cout<<'0';return *this;}if(y<0){cout<<'-';y=-y;}str s;while(y){s.pb('0'+(y&1));y>>=1;}reverse(all(s));cout<<s;}else cout<<x;return *this;}} bout;
void read(vi &v){for(auto &x:v)cin>>x;} void read(vpii &v){for(auto &p:v)cin>>p.first>>p.second;} void read(vvi &mat){for(auto &r:mat)for(auto &x:r)cin>>x;}
void read(vvi &g, int m, bool dec=true, bool dir=false){f(i, m){int u,v;cin>>u>>v;if(dec){u--;v--;}g[u].pb(v);if(!dir)g[v].pb(u);}}
void read(vvpii &g, int m, bool dec=true, bool dir=false){f(i, m){int u,v,w;cin>>u>>v>>w;if(dec){u--;v--;}g[u].pb({v,w});if(!dir)g[v].pb({u,w});}}

struct DSU{ vi p,sz; explicit
         DSU(const int n){p.resize(n),sz.resize(n,1),iota(all(p),0);}
    int  par(int x){return x==p[x]?x:p[x]=par(p[x]);}
    void merge(int x,int y){x=par(x),y=par(y);if(x!=y){if(sz[x]<sz[y])swap(x,y);p[y]=x,sz[x]+=sz[y];}}
    bool same(int x, int y){ return par(x) == par(y); }
};
tpl_<tn_ T> struct Segtree      { int n; v<T> t, nums; fn<T(T, T)> c;
    Segtree() : n(0), c([](T a, T b) { return a + b; }) {}
    Segtree(int sz, T zero, fn<T(T, T)> combine, const v<T>& init = {}) : n(sz), t(4 * sz, zero), nums(sz, zero), c(move(combine)) { if (!init.empty()) { nums = init; build(1, 0, n-1); } }
    void add(int p, T x) { modify(1, 0, n-1, p, x, false); }
    void update(int p, T x) { modify(1, 0, n-1, p, x, true); }
    T query(int l, int r) { return query(1, 0, n-1, l, r); }
private:
    void build (int i, int a, int b) { if (a == b) { t[i] = nums[a]; return; } int m = (a + b) / 2; build(2 * i, a, m); build(2 * i + 1, m + 1, b); t[i] = c(t[2 * i], t[2 * i + 1]); }
    void modify(int i, int a, int b, int p, T x, bool upd) { if (a == b) { (upd ? t[i] = x : t[i] = c(t[i], x)); return; } int m = (a + b) / 2; (p <= m ? modify(2 * i, a, m, p, x) : modify(2 * i + 1, m + 1, b, p, x)); t[i] = c(t[2 * i], t[2 * i + 1]); }
    T query  (int i, int a, int b, int l, int r) { if (r < a || b < l) return T(); if (l <= a && b <= r) return t[i]; int m = (a + b) / 2; return c(query(2 * i, a, m, l, r), query(2 * i + 1, m + 1, b, l, r)); }
};
tpl_<tn_ T, tn_ U>
struct LazySegtree {            // NOTE this "apply" passes in [l, r] by default! ap and cmp use {old, new op ... }
    int n; v<T> t, nums; v<U> ops; fn<T(T,T)> c; fn<T(T, U, int,int)> ap; fn<U(U,U)> cmp;
    LazySegtree(int sz, fn<T(T,T)> cmb, fn<T(T, U, int, int)> _ap, fn<U(U,U)> _cmp, const v<T>& init={}) :
    n(sz), t(4*sz), nums(sz), ops(4*sz), c(move(cmb)), ap(move(_ap)), cmp(move(_cmp)) { if(!init.empty()){ nums=init; build(1,0,n-1); } }
    void add(int l,int r,U u){ add(1,0,n-1,l,r,u); }
    T    query(int l, int r){ return query(1,0,n-1,l,r); }
private:
    void build(int i,int a,int b){
        if(a==b){ t[i]=nums[a]; return; } int m=(a+b)/2; build(2*i,a,m); build(2*i+1,m+1,b); t[i]=c(t[2*i],t[2*i+1]); }
    void applyNode(int i, const U& u,int a,int b){   t[i]=ap(t[i], u, a,b); ops[i]=cmp(ops[i], u); }
    void push(int i,int a,int b){
        int m=(a+b)/2; applyNode(2*i, ops[i], a,m); applyNode(2*i+1, ops[i], m+1, b); ops[i]=U(); }
    void add(int i,int a,int b,int l,int r,const U& u){
        if(r<a||b<l) return; if(l<=a && b<=r){ applyNode(i,u,a,b); return; } push(i,a,b); int m=(a+b)/2;
        add(2*i,   a,   m, l, r, u); add(2*i+1, m+1, b, l, r, u); t[i]=c(t[2*i],t[2*i+1]); }
    T query(int i,int a,int b,int l,int r){
        if(r<a||b<l) return T(); if(l<=a&&b<=r) return t[i]; push(i,a,b); int m=(a+b)/2;
        T L=query(2*i, a,m, l, r), R=query(2*i+1, m+1, b, l, r); return c(L,R); }
};
tpl_<tn_ T> struct BIT     { int n; v<T> t, nums; fn<T(T, T)> c;
    BIT() : n(0), c([](T a, T b) { return a+b; }) {}
    BIT(int sz, fn<T(T, T)> combine, const v<T>& init = {}, T zero = T()) : n(sz), t(sz+1, zero), nums(sz, zero), c(std::move(combine)) { if (!init.empty()) { f(i, n) add(i, init[i]); } }
    void add(int i, T x) { nums[i] += x; for (i += 1; i <= n; i += (i & -i)) t[i] = c(t[i], x); }
    void update(int i, T x) { T diff = x-nums[i]; nums[i] = x; for (i += 1; i <= n; i += (i & -i)) t[i] = c(t[i], diff); }
    T query(int i) { T res = T(); for (i += 1; i > 0; i -= (i & -i)) res = c(res, t[i]); return res; }
    T query(int l, int r) { return query(r)-query(l-1); }
};
tpl_<tn_ T> void printSegtree(int n, v<T>& t, int maxR=20, int maxD=4) { [[maybe_unused]] int rows = 0;
    fn<void(int, int, int, int)> dfs = [&](int i, int L, int R, int d) -> void { if (L>R || rows>=maxR || d>maxD) return; cout<<str(d*2,' ')<<"["<<L<<","<<R<<"]: "<<t[i]<<'\n';
        ++rows; if (L < R) {int M = (L+R)/2; dfs(2*i,   L,  M, d+1); dfs(2*i+1, M+1,R, d+1); } }; cout<<"Segtree\n"; dfs(1, 0, n-1, 0);}
tpl_<tn_ T> void printBIT(const BIT<T>& b,int maxC=16){
    cout<<"BIT:\n"; int lv=0;while((1<<lv)<=min(b.n,maxC))lv++; int c=min(b.n,maxC); v<vs> g(lv,vs(c,string(4,' ')));
    fe(i,c){int r=__builtin_ctz(i);if(r<lv){ostringstream o;o<<setw(4)<<b.t[i];g[r][i-1]=o.str();}} f(r,lv){f(c2,c)cout<<g[r][c2];cout<<"\n";}}

void dijkstra(vi& d, vvpii& adj, int a = 0) { mpq<pii> q; d[a] = 0, q.push({0, a});
    while(!q.empty()) { auto [w, u] = q.top(); q.pop(); if(w != d[u]) continue;
        for(auto [v, dw] : adj[u]) { if(w + dw < d[v]) { d[v] = w+dw; q.push({d[v], v});} } } }
tuple<vi,vi,vi> _dfs(const vvi &adj,int a=0){int n=adj.size(); vi sz(n,1), par(n,-1), dep(n,0);
    fviii dfs=[&](int u,int p,int d){par[u]=p; dep[u]=d; for(int v:adj[u]) if(v!=p){dfs(v,u,d+1); sz[u]+=sz[v];}}; dfs(a,-1,0); return {sz, dep, par};}
tuple<vi,vi,vi,vi> _dfs(vvpii &adj,int a=0){int n=adj.size(); vi sz(n,1), par(n,-1), dep(n,0), dist(n,0);
    fviii dfs=[&](int u,int p,int d){par[u]=p; dep[u]=d; for(auto [v,w]:adj[u]) if(v!=p){dist[v]=w; dfs(v,u,d+1); sz[u]+=sz[v];}}; dfs(a,-1,0); return {sz, dep, par, dist};}
vvi binaryJump(const vi& par) { int n = par.size(); int ln = log2(n)+1; vvi up(n, vi(ln, 0));
    f(i, n) up[i][0] = par[i]; rep(j, 1, ln-1) { f(i, n) { int p = up[i][j-1]; if(p==-1) up[i][j] = -1; else up[i][j] = up[p][j-1]; } } return up;}
tpl_<tn_ F> pair<vvi,vvi> binaryJumpW(const vi &par,const vi &wt, F merge){int n=par.size(),ln=log2(n)+1; vvi up(n,vi(ln,0)), cost(n,vi(ln,0));
    f(i,n){up[i][0]=par[i]; cost[i][0]=(par[i]==-1?0:wt[i]);} rep(j,1,ln-1){f(i,n){int p=up[i][j-1]; if(p==-1){up[i][j]=-1; cost[i][j]=cost[i][j-1];} else{up[i][j]=up[p][j-1];
        cost[i][j]=merge(cost[i][j-1],cost[p][j-1]);}}} return {up,cost};}
pair<int,int> getLCA(const vvi& up,const vi& dep,int u,int v,const vvi* wup=nullptr, const fn<int(int, int)>& F=ad){
    int ln=up[0].size(), dist=0; if(dep[u]<dep[v])swap(u,v); int d=dep[u]-dep[v]; rep(j,0,ln-1) if(d&(1<<j)){ if(wup) dist=F(dist,(*wup)[u][j]); u=up[u][j]; }
    if(u==v) return {u,dist}; repr(j,ln-1,0) if(up[u][j]!=up[v][j]){ if(wup){ dist=F(dist,(*wup)[u][j]); dist=F(dist,(*wup)[v][j]); } u=up[u][j]; v=up[v][j]; }
    if(wup){ dist=F(dist,(*wup)[u][0]); dist=F(dist,(*wup)[v][0]); } return {up[u][0],dist}; }
tpl_<class T, class U> T fstTrue(T l, T r, U ff) { for(++r; l < r;) { T m = l+(r-l) / 2; if(ff(m)) r = m; else l = m+1; } return l; }
tpl_<class T, class U> T lstTrue(T l, T r, U ff) { for(++r; l < r;) { T m = l+(r-l) / 2; if(ff(m)) l = m+1; else r = m; } return l-1; }
tpl_<class T> bool       ckmn(T& a, const T& b) {return b < a ? a = b, 1 : 0;}  tpl_<class T> bool ckmx(T& a, const T& b) {return a < b ? a = b, 1 : 0;}

struct pairHash{tpl_<class T1,class T2>size_t operator()(const pair<T1,T2>&p)const{return hash<T1>{}(p.ff)^ (hash<T2>{}(p.ss)<<1);}};
struct vectorHash{tpl_<class T>size_t operator()(const v<T>&v)const{size_t val=0;for(const T&i:v)val^=hash<T>{}(i)+0x9e3779b9+(val<<6)+(val>>2);return val;}};
vpii dirs={{1,0},{0,-1},{0,1},{-1,0}}; map<char, int> dirMap={{'E',0},{'S',1},{'N',2},{'W',3}}; auto bound=[](auto y,auto x,auto m,auto n){return y>=0&&y<m&&x>=0&&x<n;};

    cx_ int N = 100000; cx_ int MOD=1e9+7; cx_ int INF=1e9; cx_ ll INFL=0x3f3f3f3f3f3f3f3f; cx_ auto en = "\n"; cx_ auto sp = " ";
inline int fpow(int a, int b) { int res = 1; a %= MOD; while (b > 0) { if (b & 1) res = res * a % MOD; a = a * a % MOD; b >>= 1; } return res; } inline int inv(int x) { return fpow(x, MOD-2); }
cx_ int add(int a, int b) { return (a+b < MOD ? a+b : a+b-MOD); } cx_ int mult(int a, int b) { return (a*b < MOD ? a*b : a*b % MOD); } cx_ int ceil(int num, int den) { return num >= 0 ? (num + den - 1) / den : num / den; }
vb sieve(const int n){vb p(n+1,true);p[0]=p[1]=false;for(int i=2;i*i<=n;++i)if(p[i])for(int j=i*i;j<=n;j+=i)p[j]=false;return p;} vi sieveList(int n){vb p=sieve(n);vi primes; rep(i, 2, n) if(p[i]) primes.pb(i); return primes;}
vi sieveSPF(int n) {vi spf(n+1); fe(i, n) spf[i] = i; for(int i = 2; i*i<=n; ++i) { if(spf[i] != i) continue;for(int j = i*i; j <= n; j += i) {if(spf[j]==j) spf[j]=i;}}return spf;}
pair<vi, vi> initFact(int n) { vi fa(n+1), ifa(n+1); fa[0] = 1; fe(i, n) fa[i] = mult(fa[i-1], i); ifa[n] = inv(fa[n]); repr(i, n-1, 0) ifa[i] = mult(ifa[i+1], i+1); return {fa, ifa}; }
class Matrix {public: vvi v; explicit Matrix(int n): v(n, vi(n, 0)){}
    Matrix operator*(const Matrix &m) const {int n=v.size(); Matrix r(n); f(i,n) f(k,n) f(j,n) r.v[i][j]=(r.v[i][j]+v[i][k]*m.v[k][j])%MOD; return r;}
    Matrix operator^(int64_t p) const {int n=v.size(); Matrix r(n), b=*this; f(i,n) r.v[i][i]=1; while(p){if(p&1)r=r*b; b=b*b; p>>=1;} return r;}};


int t, k, n, m;
void solve() {
    
}

int32_t main() {
    setIO();
    // int t; cin>>t; f(i, t) solve();
}
