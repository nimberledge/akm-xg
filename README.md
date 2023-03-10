# akm-xG
A Julia suite for Football Data Science, building up to a smarter xG model. 

## Some Context
Football, the beautiful game, tends to pose a unique challenge to those analyzing the game at a high level. Despite the wealth of statistics generated during games such as possession, shots, passes, tackles, saves, etc., enthusiasts at all levels have found that few, if any, of these quantitative measurements tend to be good predictors of performance in a game. As such, expertise in football tends to manifest as a subjective judgement, largely guided by the "eye test" - a term to describe the intangibles that create insight based on watching thousands of games. Nonetheless, as the game evolved year-on-year, the need for data-driven decision making arose across all levels. The search for the best predictors of both individual and team performance in the sport is an ongoing endeavour that has an effect across all levels of the sport - from scouting talent to tactical insights to high-level sports journalism. 

In the mid 2010s, a new kind of football statistic made its way into the mainstream football fan's radar - expected goals (xG). The core concepts that drive the xG-models were developed as early as the 1960s, by some accounts [1]. The advent of xG changed the outlook of football statistics, proving not only to be an accurate predictor of team performance, but also providing a foundation for advancements in other metrics relevant to the sport, including xA (expected assists), xThreat (expected threat), and defensive coverage [2]. xG models changed the landscape of football statistics, bringing much needed objectivity into decisions taken in the sport at the highest levels. 

This project is personal passion project - marrying my love for the sport of football with my love for building programs. I intend to build a suite of xG models at different levels of detail - starting from the very basics and building up to hopefully a sophisticated model that takes many features into consideration to evaluate the quality of chances created in a football game. In my view, there are certain limitations of the popular xG models in current use, especially when it comes to extrapolated stats like xA. This project will encapsulate my investigative journey into xG models, football statistics, and sports data science, in order to explain, if not bridge, the gap between my intuition ("eye test") and the data-driven models currently in popular use.

## What is xG (expected goals)?
In short, the xG of a chance can be described as the "probability that the average player scores a goal" from the chance [3]. At a high level, the xG of a chance is a function that takes in all relevant attributes of the chance - distance from goal, angle to goal, type of shot, type of assist, etc., and spits out a number between 0 and 1 that describes the probability that a shot taken will result in a goal. The simplest possible xG model might look only at the location of the shot on the field, count the total number of shots and total number of goals from each position on the field, and use that ratio as the probability of scoring. As we begin to add features such as the type of shot, type of assist, and positions of teammate and opposition players, we might look towards using a machine-learning based approach in order to fit the probabilities accurately to all parameters in the model. 

## akm-xG
Courtesy of [Statsbomb](https://statsbomb.com/what-we-do/hub/free-data/), there exists a repository of rich, open-source football data. This repository contains detailed information on events like passes, carries, defensive actions, and of course shots, in the 1000+ games available in the dataset. While it is possible that this may not quite be enough data, it is difficult to see myself overcome this problem without significant investment. 

This project will use the Julia [4] programming language to implement these models to showcase the powerful capabilities and library support offered by the language. Julia also allows us to create notebook environments for more interactive / visual tasks - something very popular in the data science community.

## Short-term goals

- [x] Create a visualization tool to draw a football pitch as per the data format coordinates (defined by [Statsbomb repo](https://github.com/statsbomb/open-data/tree/master/doc))
- [x] Create basic library functions to parse and extract relevant data for xG models
- [ ] Perform rudimentary statistical analysis of shot data, export to a convenient format for processing
- [ ] Implement fundamental xG models based on linear/logistic regression in 1-2 parameters
- [ ] Create visualization tools for different event types in the data (pass, carry, tackle, etc.)
- [ ] Introduce a multi-parameter ML-based model for xG

## Medium-term goals

- [ ] Experiment with different parameters not directly available from the event data (e.g. game-state)
- [ ] Experiment with encoding position data for teammates and opposition
- [ ] Build extension statistics to xG - xA, xThreat, etc.
- [ ] Refactor toolkit for use as a public open-source Julia library

## Long-term goals

- [ ] Work towards using Statsbomb Stats360 data as a primary source of input to the model, using multiple frames to gauge fuzzy stats like xThreat
- [ ] Work towards creating an xA model that doesn't rely on a shot being taken (i.e. a good cross should have non-zero xA even if a striker fails to reach it)
- [ ] Work towards using CV concepts to analyze video frames of games and build an ML model that applies the eye-test in real-time

## If you're interested in Football Data/Statistics

Collection of links that provide some unique perspectives on football performance via statistics / models

1. [Club Elo](http://clubelo.com/) - ELO models applied to European club football, stretching back many decades
2. [Opta AI for Sports](https://www.statsperform.com/artificial-intelligence/) - AI solutions for a wide range of sports data applications
3. [Mathematical Modelling of Football](https://www.youtube.com/watch?v=yX85v-ASzQw&list=PLedeYskZY0vBOdQ6Uc9eZjZ2-nz1JT3R7&ab_channel=FriendsofTracking) - Youtube course on football data science

### Citations
[1] https://thesefootballtimes.co/2020/04/08/the-roots-of-expected-goals-xg-and-its-journey-from-nerd-nonsense-to-the-mainstream/

[2] https://www.statsperform.com/opta-analytics/

[3] https://statsbomb.com/soccer-metrics/expected-goals-xg-explained/

[4] Julia: A Fresh Approach to Numerical Computing. Jeff Bezanson, Alan Edelman, Stefan Karpinski, Viral B. Shah. (2017) SIAM Review, 59: 65???98. ()