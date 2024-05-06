# Olympic Countries Interactive Dashboard

**Overview:** The dashboard created in this project allows an individual to explore a world map of countries that participate in the Olympics. When a country is selected, the user is presented with data regarding when that country entered the Olympics, their National Olympic Committee image, and a link to their webpage.

**Description:** In this project, I used Python to scrape data from the Olympics' [website](https://olympics.com/ioc/national-olympic-committees). The data collected included the name of the country, the link to their national olympic committee webpage, and the year that they joined the Olympics. The scraped data was subsequently converted into a Pandas DataFrame and then exported to a PostgreSQL database. From there, I used SQL to perform data cleaning by changing some entries to agree with the Power BI world map visualization. By using Python again, the PostgreSQL table was converted back into a DataFrame in order to be exported as a csv file to be used with Power BI.

**Skills:** Web scraping, data cleaning, data visualization.

**Tools:** Python (Requests, Beautiful Soup, Pandas, SQLAlchemy), SQL (PostgreSQL), Microsoft Power BI.
