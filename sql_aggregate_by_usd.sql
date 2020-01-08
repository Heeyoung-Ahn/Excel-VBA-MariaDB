-- 담당자별 예결산 금액을 달러화로 집계하는 쿼리 샘플
-- 1) 집계합수에 서브쿼리로 환율을 반환하여 계산
SELECT 	a.bs_gb, a.user_nm, COUNT(a.bs_gb), SUM(a.bs_amt_krw),
			ROUND(SUM(a.bs_amt * 	(CASE a.currency_un
												WHEN 'USD' THEN 1
												ELSE (SELECT b.fx_rate_usd FROM co_account.currencies b WHERE b.currency_un = a.currency_un)
											END)), 2) AS bs_amt_usd
 FROM v_budget_settlement a
 WHERE a.suspended = 0
 GROUP BY a.bs_gb, a.user_nm WITH ROLLUP; 

 
-- 2) 공통테이블표현식으로 환율을 적용한 임시 테이블 생성 후 집계
WITH cte_budget_settlement AS(
SELECT 	a.bs_gb, a.user_nm, a.bs_amt_krw, a.currency_un, a.bs_amt,
			ROUND((CASE a.currency_un
						WHEN 'USD' THEN a.bs_amt
						ELSE a.bs_amt * (SELECT b.fx_rate_usd FROM co_account.currencies b WHERE b.currency_un = a.currency_un)
					END), 2) AS bs_amt_usd
	FROM financial_db.v_budget_settlement a
	WHERE a.suspended = 0
)
SELECT bs.bs_gb, bs.user_nm, COUNT(bs.bs_gb), SUM(bs_amt_krw), SUM(bs_amt_usd) 
	FROM cte_budget_settlement bs 
	GROUP BY bs.bs_gb, bs.user_nm;
