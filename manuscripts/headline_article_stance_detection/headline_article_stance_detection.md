# Fake News Detection 

We are exploring ways of detecting stances of documents a-la [Fake News Challenge](http://http://www.fakenewschallenge.org/). The challenge itself consists in being able to correctly identify the relationship between the headline and the body of an article as one of the following four options:

1. **Agree**
2. **Disagree**
3. **Discusses**
4. **Unrelated**

The usefulness of such a classification task is justified in the following way on the [Fake News Challenge](http://http://www.fakenewschallenge.org/) website:

> There are two important ways the Stance Detection task is relevant for fake news.
>
> 1. From our discussions with real-life fact checkers, we realized that gathering the relevant background information about a claim or news story, including all sides of the issue, is a critical initial step in a human fact checker’s job. One goal of the Fake News Challenge is to push the state-of-the-art in assisting human fact checkers, by helping them quickly gather the information they need to make their assessment. <br/><br/>In particular, a good Stance Detection solution would allow a human fact checker to enter a claim or headline and instantly retrieve the top articles that agree, disagree or discuss the claim/headline in question. They could then look at the arguments for and against the claim, and use their human judgment and reasoning skills to assess the validity of the claim in question. Such a tool would enable human fact checkers to be fast and effective.
>
> 2. It should be possible to build a prototype post-facto “truth labeling” system from a “stance detection” system. Such a system would tentatively label a claim or story as true/false based on the stances taken by various news organizations on the topic, weighted by their credibility. <br/><br/>For example, if several high-credibility news outlets run stories that Disagree with a claim (e.g. “Denmark Stops Issuing Travel Visas to US Citizens”) the claim would be provisionally labeled as False. Alternatively, if a highly newsworthy claim (e.g. “British Prime Minister Resigns in Disgrace”) only appears in one very low-credibility news outlet, without any mention by high-credibility sources despite its newsworthiness, the claim would be provisionally labeled as False by such a truth labeling system. <br/><br/>In this way, the various stances (or lack of a stance) news organizations take on a claim, as determined by an automatic stance detection system, could be combined to tentatively label the claim as True or False. While crude, this type of fully-automated approach to truth labeling could serve as a starting point for human fact checkers, e.g. to prioritize which claims are worth further investigation.
 
## Fake News Challenge Data

The fake news challenge provides a dataset with a number of headlines and article bodies associated in 49972 pairs such that we have the following stances distribution:

| Stance       | Percent |
| :--------    | :------ |
| **Agree**    | 7.36    |
| **Disagree** | 1.68    |
| **Discuss**  | 17.83   |
| **Unrelated**  | 73.13   |

Given the above distribution, it is expected that a machine learning approach to headline-body stance classification will result in a better accuracy for those pairs that are unrelated than those that disagree.

## Classification of stances using Sentence Vectors Sequences and a Long Short-Term Memory Network

The goal is to attribute to a given headline-article pair one of four stances: **agree**, **disagree**, **discusses**, or **unrelated**. We hypothesize that an article has a particular structure that combined with the headline can be used to predict the stance. To learn from such a structure we propose to first encode each document as a series of feature vectors representing the sentences sequence, a sort of *sentence embedding*. We train a *Doc2Vec* model [REF] on both the words and sentences corpora extracted from all the unique headlines and article bodies. This results in two embedding matrices, $\mathbf{M}_S$ and $\mathbf{M}_W$ for sentences and words respectively. Thus every sentence in the corpus can be represented by a vector of $N_f$ features.

We encode the $i$-th headline-article pair's structure in a matrix $\mathbf{X}_i$ wherein the $j$-th row is the vector representation of sentence $\vec{S_{ij}}$ translated relative to the headline's vector $\vec h_i$:

$$
\mathbf{X}_i = \left(\vec{S'_{ij}}\right) = \left(\vec{S_{ij}} - \vec{h_i}\right)
$$

Hence for the $i$-th document we have a set $\{\vec{S'_{ij}}\}$ of $N_i$ feature vectors of length $L$. These features are then used to train a deep neural network (DNN) classifier that consists of the following:

- three long-short term memory (LSTM) layers that take in tensors of the shape $(N_{\mathrm{batches}}, N_{\mathrm{sentences}}, L)$ and output a tensor of shape $(N_{\mathrm{batches}}, N_1)$
- a fully-connected layer with a linear activation function that takes for input the output of the above and ouputs a tensor of shape $(N_{\mathrm{batches}}, N_2)$
- a fully-connected layer with a softmax activation function that takes for input the output of the above and outputs a tensor of shape $(N_{\mathrm{batches}}, N_{\mathrm{classes}})$

Once the DNN is trained and validated , it is scored using the method proposed by the FNC team and found in *score.py*.




