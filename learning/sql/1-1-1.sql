-- 県名を地方名に再分類する
SELECT CASE pref_name
	WHEN '徳島' THEN '四国'
	WHEN '香川' THEN '四国'
	WHEN '愛媛' THEN '四国'
	WHEN '高知' THEN '四国'
	WHEN '福岡' THEN '九州'
	WHEN '佐賀' THEN '九州'
	WHEN '長崎' THEN '九州'
ELSE 'その他' END AS district,
SUM(population)
FROM PopTbl
GROUP BY CASE pref_name
	WHEN '徳島' THEN '四国'
	WHEN '香川' THEN '四国'
	WHEN '愛媛' THEN '四国'
	WHEN '高知' THEN '四国'
	WHEN '福岡' THEN '九州'
	WHEN '佐賀' THEN '九州'
	WHEN '長崎' THEN '九州'
ELSE 'その他' END;

-- 地方単位にコードを再分類する その2:Case式を一か所にまとめる
SELECT CASE pref_name
	WHEN '徳島' THEN '四国'
	WHEN '香川' THEN '四国'
	WHEN '愛媛' THEN '四国'
	WHEN '高知' THEN '四国'
	WHEN '福岡' THEN '九州'
	WHEN '佐賀' THEN '九州'
	WHEN '長崎' THEN '九州'
ELSE 'その他' END AS district,
SUM(population)
FROM PopTbl
GROUP BY district;
