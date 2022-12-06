<TeXmacs|2.1.1>

<style|generic>

<\body>
  <section|Mean and Variance via Monte Carlo Simulation>

  We ask what happens when we define a random variable

  <\equation*>
    Z<rsub|n>=X<rsub|1>+X<rsub|2>+X<rsub|3>+\<cdots\>+X<rsub|n>
  </equation*>

  where <math|X<rsub|1>,\<ldots\>X<rsub|n>> are independent of each other.
  What does the distribution of <math|Z<rsub|n>> look like given that we know
  <math|X<rsub|1>,\<ldots\>,X<rsub|n>>? <math|Z<rsub|n>> could represent the
  price of a financial asset after <math|n> timesteps, a diffusing particle,
  a sample mean and much more<text-dots>

  <\exercise>
    What other distributions could be modelled by such a sum of independent
    variables?
  </exercise>

  We begin by studying the mean and variance of the random variable
  <math|Z<rsub|n>> numerically.

  The mean <math|\<mu\><around*|(|X|)>> of a random variable <math|X> is
  given by

  <\equation*>
    \<mu\><around*|(|X|)>=<below|<big|sum>|\<omega\>\<in\>\<Omega\>>*X<around*|(|\<omega\>|)>*P<around*|(|\<omega\>|)>
  </equation*>

  where <math|\<omega\>\<in\>\<Omega\>> is a member of the event space
  <math|\<Omega\>>, <math|X:\<Omega\>\<rightarrow\>X<around*|(|\<Omega\>|)>>
  is a random variable and <math|P<around*|(|\<omega\>|)>> is the probability
  associated to the event <math|\<omega\>>. The sum only makes sense in the
  discrete case. In general, the above would be an integral

  <\exercise>
    For those of you who know about integrals, what is the analagous
    definition using an integral? When is each definition appropriate?
  </exercise>

  <\exercise>
    What does the mean represent intuitively?
  </exercise>

  The variance <math|var<around*|(|X|)>> of a random variable <math|X> is
  given by

  <\equation*>
    var<around*|(|X|)>=\<mu\><around*|(|<around*|(|X-\<mu\><around*|(|X|)>|)><rsup|2>|)>=<below|<big|sum>|\<omega\>\<in\>\<Omega\>>*<around*|(|X<around*|(|\<omega\>|)>-\<mu\><around*|(|X|)>|)><rsup|2>*P<around*|(|\<omega\>|)>
  </equation*>

  <\exercise>
    Plot mean and variance as a function of the timestep <math|n>. How does
    the mean and variance depend on the number of timesteps?
  </exercise>

  <\exercise>
    Define and fit a model for the time dependence of the variance.
  </exercise>

  In fact, on can say more about <math|Z<rsub|n>>. It turns out
  <math|Z<rsub|n>> approaches a normal distributed random variable as
  <math|n\<rightarrow\>\<infty\>>. This result is the content of the central
  limit.

  <\theorem>
    <dueto|Central Limit Theorem>Let <math|X<rsub|1>,X<rsub|2>,\<ldots\>> be
    independent random variables with finite mean and variance. Then the
    probability density <math|p<around*|(|z|)>> of
    <math|Z<rsub|n>=X<rsub|1>+X<rsub|2>+\<cdots\>+X<rsub|n>> converges to

    <\equation*>
      p<around*|(|z|)>=<frac|1|<sqrt|2*\<pi\>*\<sigma\><rsup|2>>>*exp<around*|(|-<frac|<around*|(|z-\<mu\>|)><rsup|2>|\<sigma\><rsup|2>>|)>
    </equation*>

    as <math|n\<rightarrow\>\<infty\>> where <math|\<mu\>> and
    <math|\<sigma\><rsup|2>> are the mean and variance of <math|Z<rsub|n>>.
  </theorem>

  <\exercise>
    Given the Central Limit Theorem, what kind of real world distributions
    might you expect to be normally distributed?
  </exercise>

  <\exercise>
    Explore numerically whether the theorem holds. In particular, can you
    simulate some counter examples which are not normally distributed?
  </exercise>

  To find out how the mean and variance scale with <math|n> we can use
  simpler arguments. The following series of exercises will have you show how
  mean and variance depend on the means and variance of the individual
  <math|X<rsub|i>> variables. To get warmed up, consider

  <\exercise>
    Pick a jump distribution and calculate the mean and variance for it.
    Hint: you'll find the following useful:
    <math|\<mu\><around*|(|X|)>=<below|\<Sigma\>|x>*x*p<around*|(|x|)>>,
    where <math|p<around*|(|x|)>> is the probability the random variable
    takes on the value <math|x>.
  </exercise>

  The mean has an important property: it is linear. That is,

  <\equation*>
    \<mu\><around*|(|a*X+b*Y|)>=a*\<mu\><around*|(|X|)>+b*\<mu\><around*|(|Y|)>
  </equation*>

  where <math|a,b> are real numbers and <math|X,Y> are random variables.

  <\exercise>
    Prove this.
  </exercise>

  <\exercise>
    Show that <math|\<mu\><around*|(|Z<rsub|n>|)>=<below|<above|<big|sum>|n>|i=1>\<mu\><around*|(|X<rsub|n>|)>>
    hint: use induction.
  </exercise>

  It can be shown that

  <\equation*>
    var<around*|(|X|)>=\<mu\><around*|(|X<rsup|2>|)>-\<mu\><around*|(|X|)><rsup|2>=<below|<big|sum>|x>*p<around*|(|x|)>*x<rsup|2>-<around*|(|<below|<big|sum>|x>*p<around*|(|x|)>*x|)><rsup|2>
  </equation*>

  <\exercise>
    Prove this. Hint: expand <math|\<mu\><around*|(|<around*|(|X-\<mu\>|)><rsup|2>|)>=\<mu\><around*|(|X<rsup|2>-2*\<mu\>*X+\<mu\><rsup|2>|)>>
    and use linearity of mean.
  </exercise>

  <\exercise>
    Show that <math|var<around*|(|a*X|)>=a<rsup|2>*var<around*|(|X|)>> where
    <math|a> is a real number.
  </exercise>

  Finally, we are now in a position to treat the variance of a sum. It can be
  shown that independence of two random variables implies that the covariance
  is zero. This means

  <\equation*>
    X,Y independent\<Longrightarrow\>cov<around*|(|X,Y|)>=\<mu\><around*|(|<around*|(|X-\<mu\><around*|(|X|)>|)>*<around*|(|Y-\<mu\><around*|(|Y|)>|)>|)>=\<mu\><around*|(|X*Y|)>-\<mu\><around*|(|X|)>*\<mu\><around*|(|Y|)>=0
  </equation*>

  <\exercise>
    Using independence of <math|X> and <math|Y>, derive an expression for
    <math|var<around*|(|X+Y|)>>.
  </exercise>

  By induction you can now get the final expression for the variance.

  <\exercise>
    What is <math|var<around*|(|Z<rsub|n>|)>> as a function of the variances
    <math|var<around*|(|X<rsub|i>|)>>?
  </exercise>

  <section|Kelly Betting>

  You are a gambler. The amount of money you have to gamble with is <math|x>.
  The casino is willing to offer you the following bet. You may bet any
  fraction <math|f> of your bankroll <math|x>. With probability <math|p> the
  casino will pay you <math|b> times what you bet, so <math|b*f*x>. With
  probability <math|1-p> the casino wins your bet and you lose <math|x*f>. In
  this section you'll investigate what fraction <math|f> is optimal in the
  sense that it maximises mean returns.

  <\exercise>
    Implement the function <em|meanreturns>, which calculates the mean return
    over <math|N> trajectories and <math|nt> bets, given parameters
    <math|f,b,p> and the starting bankroll <math|x<rsub|0>>.
  </exercise>

  <\exercise>
    Investigate what fraction is optimal.
  </exercise>

  This problem can in fact be solved analytically (meaning on paper by hand).
  The result is the formula

  <\equation*>
    f<rsup|\<ast\>>=p-<frac|1-p|b>
  </equation*>

  where <math|f<rsup|\<ast\>>> is the optimal fraction.
</body>

<initial|<\collection>
</collection>>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|1|../../.TeXmacs/texts/scratch/no_name_1.tm>>
    <associate|auto-2|<tuple|2|2|../../.TeXmacs/texts/scratch/no_name_1.tm>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Mean
      and Variance via Monte Carlo Simulation>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Kelly
      Betting> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>