<TeXmacs|2.1.1>

<style|generic>

<\body>
  <section|Random Variables>

  Mathematically, a <em|random variable> is a function
  <math|X:\<Omega\>\<rightarrow\>E,\<omega\>\<mapsto\>X<around*|(|\<omega\>|)>>
  assigning to each outcome in the event space <math|\<Omega\>> some value in
  <math|E>. The <em|probability> that the random variable takes on a value in
  the set <math|A\<subseteq\>E> is defined as

  <\equation*>
    P<around*|(|X\<in\>A|)>=\<bbb-P\><around*|(|<around*|{|\<omega\>\<in\>\<Omega\>:X<around*|(|\<omega\>|)>\<in\>A|}>|)>
  </equation*>

  where <math|\<bbb-P\>> is a so called <em|probability measure>. The
  probability measure <math|\<bbb-P\><around*|(|S|)>> tells you what
  proportion of events in <math|\<Omega\>> are in <math|S>. For example, let
  <math|X> be a random variable with <math|X:<around*|[|0,1|]>\<rightarrow\><around*|[|0,5|]>,\<omega\>\<mapsto\>5\<omega\>>.
  Now we ask what is the probability that <math|X> takes on a value in the
  interval <math|<around*|[|4,5|]>>, so, <math|A=<around*|[|4,5|]>>. Then

  <\equation*>
    <around*|{|\<omega\>\<in\>\<Omega\>:X<around*|(|\<omega\>|)>\<in\>A|}>=<around*|{|\<omega\>\<in\><around*|[|0,1|]>:5*\<omega\>\<in\><around*|[|4,5|]>|}>=<around*|[|0.8,1|]>
  </equation*>

  To calculate <math|\<bbb-P\><around*|(|<around*|[|0.8,1|]>|)>>, we ask what
  proportion of events from the interval <math|<around*|[|0,1|]>> are in
  <math|<around*|[|0.8,1|]>>. As you might guess, the answer is 20%.

  There are multiple equivalent ways of conceptualising this idea. If you
  like, you can think of the probability measure of a set <math|S> as
  measuring what proportion of the volume of the event space will be mapped
  into the set <math|S>. Or, you can think of throwing darts at your event
  space and asking what proportion of darts land in your set <math|S>. Or, if
  you know about integrals, you can imagine integrating over the set <math|S>
  and dividing by the integral over the whole event space. It's worth
  thinking of the event space as a source of randomness and a random variable
  as a function which takes the source of randomness and maps it onto values
  which occur with a certain probability.

  How do we implement the concept of a random variable on a computer? Most
  languages have implementations of <em|random number generators (RNG)> built
  in. RNGs allow you to generate random numbers in the interval
  <math|<around*|[|0,1|]>> \U to throw a dart, if you like. To get samples
  from other random variables you'll need to take this source of randomness
  and transform it in such a way as to yield a distribution of values you
  want. For example, say you wanted a random variable which has a 60% chance
  of returning 1 and a 40% chance of returning 0. Then you would define a
  function <math|X:<around*|[|0,1|]>\<rightarrow\><around*|{|0,1|}>> as
  follows

  <\equation*>
    X<around*|(|\<omega\>|)>=<choice|<tformat|<table|<row|<cell|1>|<cell|if
    \<omega\>\<in\><around*|[|0,0.6|]>>>|<row|<cell|0>|<cell|if
    \<omega\>\<in\><around*|(|0.6,1|]>>>>>>
  </equation*>

  This way, 60% of the time the random number generator lands in
  <math|\<omega\>\<in\><around*|[|0,0.6|]>> and so
  <math|X<around*|(|\<omega\>|)>=1> 60% of the time. 40% of the time the RNG
  yields <math|\<omega\>\<in\><around*|(|0.6,1|]>> and so
  <math|X<around*|(|\<omega\>|)>=0> 40% of the time.

  <\exercise>
    Implement a function <math|bernoulli<around*|(|\<omega\>,p|)>> which
    takes a value <math|\<omega\>\<in\><around*|[|0,1|)>> and a probability
    <math|p> as inputs and returns <em|true> with probability <math|p> and
    <em|false> with probability <math|1-p>.
  </exercise>

  <\exercise>
    Implement a function <math|uniform<around*|(|\<omega\>,a,b|)>> which
    returns a value between <math|a> and <math|b>, given a random number
    <math|\<omega\>\<in\><around*|[|0,1|)>>. All values in
    <math|<around*|[|a,b|]>> should be equally probable.
  </exercise>

  <\exercise>
    Experiment with making other random variables and plot their probability
    distributions. Or combine ones you've already made by adding,
    multiplying, etc. Another direction you could go with this is to try to
    make it as hard as possible to guess which <math|\<omega\>> your random
    variable took as an input to generate a given output.
  </exercise>

  <\exercise>
    If you add two random variables what probability distribution do you get
    for the sum? You probably don't have the mathematical tools to work this
    out precisely in general, but maybe you can get a qualitative answer (or
    try to think of some very simple random variables where you can work it
    out precisely).
  </exercise>

  For the two simple cases above it is possible to essentially guess what
  function will yield the random variable you want. Let us now try to
  understand a more complex case. Say you want to sample a random number in
  the interval <math|<around*|[|0,\<infty\>|)>>, such that the
  <em|probability density (pdf)> at each point is given by

  <\equation*>
    pdf<around*|(|x|)>=e<rsup|-x>
  </equation*>

  where the probability density represents the amount of probability in an
  infinitessimal volume a the point <math|x>. Since, we are dealing with just
  a number, volumes are lengths on the real line. To figure out how to sample
  from such a distribution, we need to convert the probability density to a
  <em|cumulative probability density (cdf)>

  <\equation*>
    cdf<around*|(|x|)>=P<around*|(|X\<leqslant\>x|)>=<below|<above|<big|int>|x>|-\<infty\>>*pdf<around*|(|x|)>*d
    x
  </equation*>

  If you don't know what the funny sign on the right means, no need to worry.
  You don't need to know. In the case of the exponential distribution above,
  we have

  <\equation*>
    cdf<around*|(|x|)>=<below|<above|<big|int>|x>|0>*e<rsup|-x>*d
    x=1-e<rsup|-x>
  </equation*>

  <\exercise>
    If you know about integration, calculate this integral yourself. If you
    don't know about integrals, but you know about derivatives, check that
    <math|<frac|d|d x>cdf<around*|(|x|)>=pdf<around*|(|x|)>> for the
    exponential distribution.
  </exercise>

  The trick to sampling from the exponential distribution is to invert the
  <math|cdf> function and use it as our random variable, so we define

  <\equation*>
    X:<around*|[|0,1|]>\<rightarrow\><around*|[|0,\<infty\>|)>,\<omega\>\<mapsto\>cdf<rsup|-1><around*|(|\<omega\>|)>
  </equation*>

  with the inverse function <math|cdf<rsup|-1>> defined such that
  <math|cdf<around*|(|cdf<rsup|-1><around*|(|\<omega\>|)>|)>=\<omega\>> and
  <math|cdf<rsup|-1><around*|(|cdf<around*|(|x|)>|)>=x>.

  <\exercise>
    Work out the inverse of the cdf for the exponential distribution and
    implement the random variable. Plot the histogram and see if it looks
    right. Try plotting the exponential pdf on the same plot as the
    histogram.
  </exercise>

  <\exercise>
    Why does this method work? How can we know that each value will be
    sampled with the right probability density? Does this method work for any
    random variable you want to sample?
  </exercise>

  Note that the implementation of the built in randexp function works
  differently, since there are more performant ways to sample from an
  exponential distribution. See <hlink|here|https://github.com/JuliaLang/julia/blob/a41ae5bb911819f1b3011a654e2bb68c39be8115/stdlib/Random/src/normal.jl#L127-L151>.

  Finally, let me provide a method that works even for very complicated
  distributions which are hard to integrate or invert. The basic idea is to
  sample from a distribution you know how to sample from and then reject some
  samples, such that the proprtion of samples at a given value matches the
  probability density there. As an example, let's take the distribution

  <\equation*>
    pdf<around*|(|x|)>=<frac|2|\<pi\>><sqrt|1-x<rsup|2>><space|1em>for<space|1em>-1\<leqslant\>x\<leqslant\>1
  </equation*>

  <\exercise>
    If you know how to integrate, check that this distribution is normalised,
    so <math|P<around*|(|X\<in\><around*|[|-1,1|]>|)>=<below|<above|<big|int>|1>|-1>pdf<around*|(|x|)>*d
    x=1> (Hint: substitute <math|u=sin<around*|(|\<theta\>|)>> and use
    <math|sin<rsup|2><around*|(|\<theta\>|)>+cos<rsup|2><around*|(|\<theta\>|)>=1>
    and the fact that the integral over one period of
    <math|sin<rsup|2><around*|(|\<theta\>|)>> is equal to the integral over
    <math|cos<rsup|2><around*|(|\<theta\>|)>>). If you do not know how to
    integrate, you can still try to see what this function represents
    geometrically and convince yourself on geometric grounds that
    <math|P<around*|(|X\<in\><around*|[|-1,1|]>|)>=1>.
  </exercise>

  The algorithm to sample from this distribution works like so

  <\enumerate-numeric>
    <item>Sample a value <math|x> uniformly between -1 and 1.

    <item>Sample a value <math|y> uniformly between 0 and 1.

    <item>If <math|y\<gtr\>pdf<around*|(|x|)>>, reject the sample <math|x>
    and go back to step 1. Else, accept the sample and return <math|x>.
  </enumerate-numeric>

  This algorithm is called rejection sampling and you'll see it show up again
  in this course a few times.

  <\exercise>
    Implement the algorithm. Plot a histogram of samples to check if it
    works.
  </exercise>

  <\exercise>
    Why does this algorithm work?
  </exercise>

  <\exercise>
    How might you use the algorithm for this particular distribution to
    numerically estimate the value of <math|\<pi\>>?
  </exercise>

  <section|Monte Carlo Simulation of Random Walks>

  We begin with an ensemble of intial positions <math|x<rsub|0>>. Then, for
  each position, we update the position by a random rule. For example,

  <\equation*>
    x<rsub|n+1>=x<rsub|n>+<choice|<tformat|<table|<row|<cell|1>|<cell|with
    probability <frac|1|2>>>|<row|<cell|-1>|<cell|with probability
    <frac|1|2>>>>>>
  </equation*>

  <subsection|The Central Limit Theorem>

  <\theorem>
    <dueto|Central Limit Theorem>Let <math|<around*|{|X<rsub|1>,\<ldots\>,X<rsub|n>,\<ldots\>|}>>
    be independent and identically distributed random variables with finite
    mean <math|\<mu\>> and finite variance <math|\<sigma\><rsup|2>>. Then,
    the distribution of

    <\equation*>
      Z<rsub|n>=<frac|X<rsub|1>+\<cdots\>+X<rsub|n>|n>
    </equation*>

    converges to a gaussian distribution with mean <math|\<mu\>> and variance
    <math|<frac|\<sigma\><rsup|2>|n>>.
  </theorem>

  <subsection|Discrete Random Walk>

  <subsection|Diffusion and Superdiffusion>

  <subsection|Drift and Diffusion in a Box, in a Well and in a Periodic Well>

  <subsection|Optimal Betting Strategy \U The Kelly Criterion>

  \ 

  <section|Markov Chains and a bit of Linear Algebra>

  <section|Nash Equilibrium and Poker>
</body>

<initial|<\collection>
</collection>>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-2|<tuple|2|?>>
    <associate|auto-3|<tuple|2.1|?>>
    <associate|auto-4|<tuple|2.2|?>>
    <associate|auto-5|<tuple|2.3|?>>
    <associate|auto-6|<tuple|2.4|?>>
    <associate|auto-7|<tuple|2.5|?>>
    <associate|auto-8|<tuple|3|?>>
    <associate|auto-9|<tuple|4|?>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Random
      Variables> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>