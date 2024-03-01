<h1 style="text-align: center;"><b>Credit Card Customer Retention<br>An Ensemble Learning Analysis</b></h1>
<br><br><br>
<h1 style="text-align: center;"><b>Executive Summary</b></h1>
<h3><b>Introduction</b></h3>
<p>A business manager of a consumer credit card portfolio is facing the problem of customer attrition. They want the data analyzed in order to find the reasons for this and to better predict customers who are likely to leave.</p>
<p>In this project, we will work to find valuable information that the portfolio manager can use in order to retain customers. To achieve this objective, the underlying factors driving customer attrition will be investigated. This will involve employing various techniques, including data analysis and feature engineering. Subsequently, ensemble learning models will be used to model the data, proactively identifying potential churned customers while gaining insights into the reasons behind customer attrition. The primary question to be answered as a result of this project is: 
<ul>
    <li>What are the characteristics of churning customers?</li>
</ul></p><br>
<h3><b>Methodology</b></h3>
<p><b>Data Cleaning</b></p>
<p>The data wrangling process in this project was relatively brief. It included checking for nulls and duplicates, string manipulations, and removing a few unknown values. After the unknown values were removed, the class balance was identified for the singular dataset used throughout this document.</p><br>
<p><b>Data Analysis</b></p>
<p>The data analysis section began by generating summary statistics followed by a couple of grouped aggregate calculations to identify the measures of central tendency grouped by attrition for a couple of variables. This provided information regarding some potential characteristics that separate retained and attrited customers. Afterwards, data visualizations were created in order to visually identify some differences and similarities between the two customer groups.</p><br>
<p><b>Feature Engineering</b></p>
<p>A concise feature engineering section involved creating a feature for the average amount spent per transaction per customer as well as performing dummy encoding for the categorical response variable.</p><br>
<p><b>Data Modeling</b></p>
<p>In this project, the data modeling process involved creating two separate models using ensemble learning techniques. Both the random forest and gradient boosting machine were implemented using cross-validation in order to identify the best hyperparameters. After these models were trained, they were compared using four metrics: accuracy, recall, precision, and the F1 score. A champion model was chosen and used to predict on unseen data, and these results were used to evaluate the final model performance and to gain insights about the data.</p><br>
<h3><b>Results</b></h3>
<p><b>Model Performance</b></p>
<p>The gradient boosting machine performed better than the random forest in every metric. With XGBoost, the F1 score improved by approximately 3%, and the recall saw an increase of around 3.6% over the random forest. The cross-validation scores for the XGBoost model are as follows:
<ul>
    <li>Accuracy: 96.70%</li>
    <li>Recall: 0.9156</li>
    <li>Precision: 0.8706</li>
    <li>F1 Score: 0.8924</li>
</ul>
</p><br>
<p><b>Feature Importance</b></p>
<p>The most influential features regarding customer attrition are the ones relevant to product engagement such as the total number of transactions that they made and their change in transaction count from one quarter to the next. The most important variable is how much they've spent in total as a credit card customer. Because of this, it has been concluded that customer retention may be improved by inspiring increased product engagement.</p><br>
<h3><b>Strategic Recommendations</b></h3>
<p>Through an in-depth analysis of the data, I was able to successfully obtain valuable information regarding credit card customer behavior and develop a predictive model. The most relevant insights to the business problem are that the customers who are leaving are the ones who:
<ul>
    <li>Make fewer total transactions</li>
    <li>Have fewer total transaction amounts</li>
    <li>Spend less per transaction</li>
    <li>Use their credit cards less over time</li>
</ul></p>
<p>Based on this information, I have curated the following list of strategic recommendations:</p>
<ol>
    <li>Tiered Benefits
    <ul>
        <li>Introduce tiered benefits or loyalty rewards based on card usage. Offer additional rewards, perks, or higher cashback rates for reaching specific spending thresholds.</li>
    </ul></li>
    <li>Spending Challenges
    <ul>
        <li>Develop a rewards system with gamified elements designed to encourage increased card usage. Offer challenges, levels, or surprise rewards tied to specific spending milestones, creating an engaging experience for cardholders.</li>
    </li></ul>
    <li>Segmented Marketing
    <ul>
        <li>Focus marketing efforts towards customers displaying reduced spending or infrequent transactions. Create strategies to encourage card usage tailored specifically for these customers.</li>
    </ul></li>
</ol>
<p>These recommendations are designed to improve credit card customer retention by increasing product engagement, utilizing data-driven insights derived from data analysis and machine learning models.</p>