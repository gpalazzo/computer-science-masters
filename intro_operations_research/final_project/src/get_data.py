import yfinance as yf

vale = yf.Ticker("VALE3.SA")
petr = yf.Ticker("PETR4.SA")
ggbr = yf.Ticker("GGBR4.SA")
csn = yf.Ticker("CSNA3.SA")

vale_df = vale.history(
    start="2020-01-01", end="2020-12-31", interval="1d"
).reset_index()[["Date", "High", "Low"]]

petr_df = petr.history(
    start="2020-01-01", end="2020-12-31", interval="1d"
).reset_index()[["Date", "High", "Low"]]

ggbr_df = ggbr.history(
    start="2020-01-01", end="2020-12-31", interval="1d"
).reset_index()[["Date", "High", "Low"]]

csn_df = csn.history(start="2020-01-01", end="2020-12-31", interval="1d").reset_index()[
    ["Date", "High", "Low"]
]

vale_df.loc[:, "VALE3"] = (vale_df["High"] + vale_df["Low"]) / 2.0
vale_df = vale_df.drop(columns=["High", "Low"])

petr_df.loc[:, "PETR4"] = (petr_df["High"] + petr_df["Low"]) / 2.0
petr_df = petr_df.drop(columns=["High", "Low"])

ggbr_df.loc[:, "GGBR4"] = (ggbr_df["High"] + ggbr_df["Low"]) / 2.0
ggbr_df = ggbr_df.drop(columns=["High", "Low"])

csn_df.loc[:, "CSNA3"] = (csn_df["High"] + csn_df["Low"]) / 2.0
csn_df = csn_df.drop(columns=["High", "Low"])

final_df = (
    vale_df.merge(petr_df, on=["Date"], how="inner")
    .merge(ggbr_df, on=["Date"], how="inner")
    .merge(csn_df, on=["Date"], how="inner")
)

final_df.to_csv("../data/tickers.csv", index=False)
