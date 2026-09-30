---
layout: projectNoImage
type: project
status: posted
published: true
redirect_from:
  - /projects/current/the-frontier/
  - /projects/future/the-frontier/
  - /projects/past/the-frontier/
  - /projects/current/2026-09-29-the-frontier/
  - /projects/future/2026-09-29-the-frontier/
  - /projects/past/2026-09-29-the-frontier/
title: The Frontier
description: What actually is the frontier?
image: /projects/2026-09-29-the-frontier/frontier.png
pubdate: 2026-09-29
lastUpdated: 2026-09-29
---
<a href="/projects/2026-09-29-the-frontier/capability-cost.svg">
    <img src="/projects/2026-09-29-the-frontier/capability-cost.svg"
         alt="Capability vs cost for 52 frontier models, with the Pareto frontier envelope"
         class="full-width-photo">
</a>

The underlying data:
[the taxonomy — every lab, model, benchmark score, and its sources](https://github.com/cjtrowbridge/llm-pareto-frontier/tree/main/taxonomy)

People have this idea that "the frontier" means whatever is most expensive at any given moment. The reality is that a frontier is a boundary taht stretches across a range of possiblities. (Click the linear frontier button to see the difference)

If we consider the realtionship between cost and capability, then why would the most expensive or most capable ever be the answer? Each of these satisfies only one of the factors we're looking at. The "best" option is the one closest to the point of maximum capability and minimum cost (the top left corner).

## A New Metric

In the past, I talked mostly about the relationship between cost versus MMLU as a measure of capability. Over time, this metric became saturated and easy to cheat at. Since then, LiveBench has emerged as a free, open test which challenges models on a wide variety of subjects and analytical processes. In order to score highly on LiveBench, a model needs to be good at 23 different fields from math to reasoning, from data analysis to instruction following. Even if they try to cheat (which I'm sure they are), they would have to be good at dozens of different types of tasks to score well here.

More recently, I've discussed ARC-AGI as a potentially ideal test that's difficult to cheat at, but OpenAI proved to the world that by giving it access to some kind of secret and undocumented "tool," its Astra model could go from just 17% as good as a human to 99.96% as good as a human. When we look at the relationship between scores with and without this ttool," we see the lack of similar score dispersal with different reasoning budgets, the lack of evidence for higher scores at maximum reasoning budgets versus minimum reasoning budgets, etc. This is what we call overfit. This is what we call obvious and incompetent cheating. They aren't even trying to make it look real.

ARC-AGI is therefore suddenly and unexpectedly dead.

In front of that backdrop, LiveBench emerges as a broad collection of open benchmarks which many models are tested on, and which we can independently verify. And when we look at the data, we see the pattern we would expect.

This is the tool I will be using from now on to discuss and compare capability versus cost, at least until something changes.