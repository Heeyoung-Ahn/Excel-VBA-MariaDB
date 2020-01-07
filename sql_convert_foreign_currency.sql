-- 원화로 환산할 경우
SELECT 	a.sl_id, a.currency_un,
			a.transaction_ls_amt AS row_amt,
			ROUND((CASE a.currency_un
			 	WHEN 'KRW' THEN a.transaction_ls_amt
			 	ELSE a.transaction_ls_amt * (SELECT b.fx_rate_krw FROM co_account.currencies b WHERE b.currency_un = a.currency_un)
			END), 2) AS transaction_ls_amt_krw
	FROM financial_db.v_transaction_amt_by_slip a;
	
-- 달러화로 환산할 경우
SELECT 	a.sl_id, a.currency_un,
			a.transaction_ls_amt AS row_amt,
			ROUND((CASE a.currency_un
			 	WHEN 'USD' THEN a.transaction_ls_amt
			 	ELSE a.transaction_ls_amt * (SELECT b.fx_rate_usd FROM co_account.currencies b WHERE b.currency_un = a.currency_un)
			END), 2) AS transaction_ls_amt_usd
	FROM financial_db.v_transaction_amt_by_slip a;

-- 제3국 화폐로 환산할 경우(CROSS RATE)
-- BRL을 EUR로: BRL의 USD 환산환율 / EUR의 USD 환산환율
SELECT 	a.sl_id, a.currency_un,
			a.transaction_ls_amt AS row_amt,
			ROUND((CASE a.currency_un
			 	WHEN 'EUR' THEN a.transaction_ls_amt
			 	ELSE a.transaction_ls_amt * (SELECT b.fx_rate_usd FROM co_account.currencies b WHERE b.currency_un = a.currency_un) /
			 										 (SELECT c.fx_rate_usd FROM co_account.currencies c WHERE c.currency_un = 'EUR')
			END), 2) AS transaction_ls_amt_eur
	FROM financial_db.v_transaction_amt_by_slip a;
