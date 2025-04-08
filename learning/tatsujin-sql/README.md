# 達人に学ぶSQL徹底指南書 第2版

## duckdb
### Read CSV
httsp://duckdb.org/docs/stable/data/csv/overview.html

```bash
cat fights.csv | duckdb -c "SELECT * FROM read_csv('/dev/stdin')"
```

```duckdb
SELECT * FROM 'fights.csv'
```

#### Create Table from CSV
```sql
CREATE TABLE Personnel AS
SELECT * FROM 'Personnel.csv'
```

### Execute SQL
```duckdb
.read sample.sql
```
