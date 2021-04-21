-- Sales table is the enormous table of all. Its quantities are searched frequently for market analysis. Creating the sales quantity index will speeds up the processing time noticeably.
CREATE INDEX sales_idx ON sales(quantity);
