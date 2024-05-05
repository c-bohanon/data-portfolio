<h1 style="text-align: center;"><b>Starbucks Customer Segmentation<br>A Clustering Analysis</b></h1>
<br><br><br>
<h1 style="text-align: center;"><b>Executive Summary</b></h1>
<h3><b>Introduction</b></h3>
<p>In this customer segmentation project, we will dive into Starbucks' customer and offer data in order to uncover valuable information that can enhance their promotional strategies. The purpose of this undertaking is to analyze the effectiveness of a number of promotional offers and perform customer segmentation to provide data-driven insights as to which customers are likely to respond to promotional offers and why. With this knowledge, Starbucks will more equipped to optimize the delivery of deals to customers, ensuring a higher rate of offer completion.</p>
<p>Throughout the duration of this project, we work to answer three primary questions:
<ul>
    <li>What makes an offer effective?</li>
    <li>What gets an offer viewed?</li>
    <li>How are different customers responding to offers and why?</li>
</ul></p>
<br>
<h3><b>Methodology</b></h3>
<p><b>Data Wrangling</b></p>
<p>The data wrangling process primarily included data cleaning and joins in order to parse out information from particular columns as well as combine the three dataframes into one full dataframe. After this, the data was split into two separate dataframes which served as the "launch pads" for further analysis throughout the project. One of these dataframes contained customer transaction data, while the other focused on the customers' interactions with the promotional offers.</p><br>
<p><b>Data Analysis</b></p>
<p>The data analysis section began with a univariate analysis of demographic and transaction information to better understand the data. After that was a thorough examination of the characteristics of the 10 unique offers available in the data. Then began an analysis of offer effectiveness in which was defined a metric for evaluating what makes an offer effective. In that section, we uncover which features have the greatest effect on offer viewership and completion.</p><br>
<p><b>Feature Engineering and Transformation</b></p>
<p>This segment of the project involves creating new features to calculate the average transaction amount for each individual customer in addition to some data preprocessing to prepare the data for clustering. More dataframes were also created in this section which are used during model evaluation in order to determine the characteristics of the customers within each segment determined via data modeling.</p><br>
<p><b>Data Modeling</b></p>
<p>The data modeling process involved using the K-Means algorithm to find the within cluster sum of squares (WCSS) values as well as the silhouette scores for each amount of clusters ranging from 2 to 10. With this information, an optimal number of clusters was chosen, and the K-Means algorithm was used to create a model of the data containing the customer segments.</p><br>
<h3><b>Results</b></h3>
<p><b>Offer Viewership</b></p>
<p>The use of social media as a distribution channel was found to be the most prominent variable at determining whether or not an offer is viewed. As a result, its correlation to viewership was higher than other offer characteristics such as difficulty, duration, and reward. It is worth mentioning that, although the use of social media gets an offer viewed, these views have not been translating into completions. Because of this, offers distributed via social media had lower rates of completion.</p>
<br>
<p><b>Offer Completion</b></p>
<p>Similar to offer viewership, the most important variable at determining offer completion is also the use of social media as a distribution channel, however this time it is a negative correlation. This means that sending offers to customers via social media has led to lower rates of completion. The next most important contributor to offer completion is the offer type. Perhaps counter-intuitively, discount offers are more likely to be completed than bogo offers despite having, on average, a higher difficulty and lower reward.</p>
<br>
<p><b>Customer Segmentation</b></p>
<p>By performing K-Means clustering on the dataset of customers with two features, customer percent viewership and customer percent completion, three segments can be discovered:
<ul>
    <li><b>Casual Customers - (28%)</b>
        <ul><li>
        This segment has varying rates of viewership and low rates of completion. They can be identified as those who spend less per transaction than the other two segments.</li></ul>
    </li>
    <li><b>Curious Customers - (42%)</b>
        <ul><li>
        The segment boasts the highest rate of viewership, but they also have low rates of completion. They can be identified as those who are receiving more offers via social media and less discount offers which are more likely to encourage completion.
        </li></ul>
    </li>
    <li><b>Committed Customers - (30%)</b>
        <ul><li>
        This segment as varying rates of viewership but the highest rates of completion. These customers are receiving fewer offers via social media as well as more discount offers, and they have, on average, more time to complete offers than the other two segments. This has led to their average rate of completion being nearly twice as high as the next highest segment.
        </li></ul>
    </li>
</ul></p>
<br>
<h3><b>Strategic Recommendations</b></h3>
<p>Based on the insights gained through data analysis and the K-Means clustering algorithm, I've curated the following list of strategic recommendations:
<ol>
    <li>Continuously evaluate the use of social media as an offer channel with the intention of converting views into completions. This channel is outstanding when it comes to getting views, and it could become an extremely valuable asset with an increased rate of completions.</li><br>
    <li>Consider methods to increase the average transaction amounts of the customers in the "casual" segment. With view rates similar to the "committed" segment, it is likely that they can be made to be very valuable customers.</li><br>
    <li>Generate ways to move the customers in the "curious" segment into the "committed" segment by inspiring increased rates of offer completion. This can be achieved by following the first recommendation, or by providing them with more discount offers as opposed to bogo offers.</li>
</ol></p>
