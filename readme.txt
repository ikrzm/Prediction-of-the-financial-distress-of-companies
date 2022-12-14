Financial
R visualization: Employee salaries

Second dataset
Context
This data set deals with the financial distress prediction for a sample of companies.
Content
First column: Company represents sample companies.
Second column: Time shows different time periods that data belongs to. Time series length varies between 1 to 14 for each company.
Third column: The target variable is denoted by "Financial Distress" if it is greater than -0.50 the company should be considered as healthy (0). Otherwise, it would be regarded as financially distressed (1).
Fourth column to the last column: The features denoted by x1 to x83, are some financial and non-financial characteristics of the sampled companies. These features belong to the previous time period, which should be used to predict whether the company will be financially distressed or not (classification). Feature x80 is a categorical variable.
For example, company 1 is financially distressed at time 4 but company 2 is still healthy at time 14.
This data set is imbalanced (there are 136 financially distressed companies against 286 healthy ones i.e., 136 firm-year observations are financially distressed while 3546 firm-year observations are healthy) and skewed, so f-score should be employed as the performance evaluation criterion. 



NLP: Consumer Complaints - Financial products
Context
This data is a collection of complaints about consumer financial products and services that we sent to companies for response. Complaints are published after the company responds, confirming a commercial relationship with the consumer, or after 15 days, whichever comes first
Content
The dataset comprises of Consumer Complaints on Financial 
The source of data is : https://cfpb.github.io/api/ccdb/
