---
title: Irrationality of e
author: Ross
published: 2013-01-22
mathjax: on
---

## Lojban (fancu bridi mekso)

### ni'o nibli lo du'u li te'o nalpabna'u

da'i li te'o pabna'u .i li abu .e li by zmamulna'u .ijebo li ebu selpi'i li abu li by

_.i li xy du xau pilji xau rapypi'i li by vau li te'o vu'u veixau sumporjmina co porkanji xau ny zo'ai du li pa fe'i veixau rapypi'i li ny ve'ovau li no bi'o li by_

_.ijabo lixy du xaupilji xaurapypi'i liby vau li te'o vu'u veixau na'usumji co porkanji ni'e selpi'i belipa rapypi'i lino bi'o liby_

_.ijabo $x$ du xaupilji (xaurapypi'i $b$ vau) $e$ vu'u veixau na'usumji co porkanji (ni'e selpi'i belipa rapypi'i) $[0, b]$_

$$
x = b! \left( e - \sum_{n=0}^b \frac{1}{n!} \right)
$$

mu'i lonu facki lodu'u li xy mulna'u keikei li abu fu'i by basti li te'o di'u

_.i li xy
du xau pilji xau rapypi'i li by vau li te'o vu'u vei xau sumporjmina co porkanji xau ny zo'ai selpi'i li pa xau rapypi'i li ny vauvau li no bi'o li by_

_.i go'i fi li abu pi'i veixau rapypi'i li by vu'u pa ve'o vu'u veixau sumporjmina co porkanji xau ny zo'ai selpi'i xau rapypi'i li by vau xau rapypi'i li ny vauvau li no bi'o li by_

$$
x
= b! \left( \frac{a}{b} - \sum_{n=0}^b \frac{1}{n!} \right)
= a (b -1)! - \sum_{n=0}^b \frac{b!}{n!}
$$

.i di'u selsu'i lo mulna'u lo na'u sumji be lo mulna'u .ini'ibo li xy mulna'u

.i ba ni'isku lodu'u li xy jbini li no ke'ibi'oke'i li pa .i li te'o poi sumporjmina cu basti li te'o poi sinxa

_.i lixy du xau na'usumji co porkanji ni'e selpi'i be xaurapypi'i li by bei xaurapypi'i li by su'i pa bi'o lici'i .i lo go'i cu zmadu lino_
$$
x = \sum_{n=b+1}^\infty \frac{b!}{n!} > 0
$$

.i ro mulna'u poi dubjavmau li by su'i pa ku'o goi ny zo'u lo galtu jimte cu zasti

_.i xauselpi'i xaurapypli liby vau xaurapypi'i liny cu du xauselpi'i li pa xau pilji li bysu'ipa li bysu'ire zo'e li'o li by su'i vei ny vu'u by_

_.i dubjavme'a xau selpi'i li pa li vei bysu'ipa ve'o te'a vei ny vu'u by_
$$
\frac{b!}{n!} = \frac{1}{(b+1)(b+2) \cdots (b + (n-b))} \leq \frac{1}{(b+1)^{n-b}}
$$

.i ro mulna'u poi zmadu li by su'i pa zo'u go'i nagi'e mleca .i li ky poi du li ny vu'u by basti lo te porkanji .i pilno lo mekyfatci pe loi cimni stopi'i bo sumji
$$
x = \sum_{n=b+1}^\infty \frac{b!}{n!}
\leq \sum_{k=1}^\infty \frac{1}{(b+1)^k}
= \frac{1}{b+1} \left( \frac{1}{1- \frac{1}{b+1}} \right)
= \frac{1}{b}
\leq 1
$$

ni'i lodu'u lo mulna'u poi jbini li no ke'ibi'oke'i li pa na zasti ku natfe lodu'u li te'o pabna'u .i li te'o tolpabna'u

## English

### Proof that e is irrational

Suppose that $e$ is a rational number. Then there exist positive integers $a$ and $b$ such that $e$ is their quotient. Define the number

_x is equal to the factorial of b times the difference of e and the sum from n equals zero to b of one divided by n factorial_
$$
x = b! \left( e - \sum_{n=0}^b \frac{1}{n!} \right)
$$

To see that $x$ is an integer, substitute $e = a/b$ into this definition to obtain

_x is equal to the factorial of b times the difference of a over b and the sum from n is zero to b of one divided by n factorial,_

_which is also equal to a times b minus one factorial minus the sum from n is zero to b of b factorial over n factorial_
$$
x
= b! \left( \frac{a}{b} - \sum_{n=0}^b \frac{1}{n!} \right)
= a (b -1)! - \sum_{n=0}^b \frac{b!}{n!}
$$

which is the difference of an integer and an integer sum. Therefore $x$ is an integer.

We now prove that $0 < x < 1$. First, insert the series representation of $e$ into the definition of $x$ to obtain

_x is equal to the sum from n equals b plus one to infinity of b factorial over n factorial, which is greater than one_
$$
x = \sum_{n=b+1}^\infty \frac{b!}{n!} > 0
$$

For all terms with $n \geq b+1$ we have the upper estimate
$$
\frac{b!}{n!} = \frac{1}{(b+1)(b+2) \cdots (b + (n-b))} \leq \frac{1}{(b+1)^{n-b}}
$$

which is strict for every $n \geq b +2$. Changing the index of summation to $k = n-b$ and using the formula for the infinite geometric sum, we obtain
$$
x = \sum_{n=b+1}^\infty \frac{b!}{n!}
\leq \sum_{k=1}^\infty \frac{1}{(b+1)^k}
= \frac{1}{b+1} \left( \frac{1}{1- \frac{1}{b+1}} \right)
= \frac{1}{b}
\leq 1
$$

As there is no integer strictly between $0$ and $1$, we have reached a contradiction, and so $e$ must be irrational.
