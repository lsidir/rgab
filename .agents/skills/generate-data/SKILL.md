---
name: generate-data
description: Generates the data needed for the benchmark. Used when asked to generate data for a specific scale, usually defined by the size of the planet, and for a format compatible with a specific DBMS or platform.
license: Apache-2.0
metadata:
  author: Lefteris Sidirourgos (lsidir)
  version: "1.0"
  compatibility: Generated data can be loaded into MonetDB, PostgreSQL, DuckDB.
  files:
    "scripts/*"
  homepage: https://github.com/lsidir/rgab
  tags:
    - benchmark
    - data
    - graph
    - synthetic
    - generator
---

To generate the data use the following script and run the following command

```bash
echo $((data-gen % <planet> <dbms>))
```

Replace `<planet>` with the scale factor planet and `<dbms>` with the target compatible platform as described in the `compatibility` field in the YAML frontmatter.
