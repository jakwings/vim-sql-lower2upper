" Automatically turn SQL keywords from lower case to upper case while typing.
"
" This plugin is turned on by default.  In insert mode, you can press
" control-l to turn it off.  When you leave insert mode, it will be
" automatically turned on again.
"
" Options:
" g:SQL_lower2upper_mode = [ 'SQLite' ]
" g:SQL_lower2upper_extra_keywords = [ User-provided Keywords ]
"
" Author: Jak Wings
" Source: https://github.com/jakwings/vim-sql-lower2upper
" Update: 2015-07-27


let b:SQL_lower2upper_on = 1
let b:SQL_lower2upper_keywords = []

if !exists('g:SQL_lower2upper_mode') || !g:SQL_lower2upper_mode
  let g:SQL_lower2upper_mode = 'SQLite'
endif

function! s:Setup(keywords) abort
  for word in b:SQL_lower2upper_keywords
    execute 'iabbrev <expr> <buffer> ' . tolower(word)
          \ . ' <SID>Transform("' . word . '")'
  endfor
  unlet b:SQL_lower2upper_keywords
endfunction

function! s:Transform(word)
  " Don't work.  synID and synIDattr are debug commands?
  "if synIDattr(synID(line('.'), col('.'), 1), 'name') !~ '\c\(string\|comment\)'
  "  return a:word
  "endif
  "return tolower(a:word)
  if b:SQL_lower2upper_on
    return a:word
  endif
  return tolower(a:word)
endfunction

function! s:Toggle()
  let b:SQL_lower2upper_on = !b:SQL_lower2upper_on
  return ''
endfunction

function! s:TurnOn()
  let b:SQL_lower2upper_on = 1
endfunction

function! s:AddWords(words)
  for word in a:words
    let b:SQL_lower2upper_keywords += split(word, '\W\+')
  endfor
endfunction

" SQL Keywords as per ISO Standard
" http://developer.mimer.com/validator/sql-reserved-words.tml
" http://www.postgresql.org/docs/9.4/interactive/sql-keywords-appendix.html
call s:AddWords([
      \ 'AS', 'AT', 'BY', 'DO', 'GO', 'IF', 'IN', 'IS', 'LN', 'NO', 'OF',
      \ 'ON', 'OR', 'TO', 'ABS', 'ADD', 'ALL', 'AND', 'ANY', 'ARE', 'ASC',
      \ 'AVG', 'BIT', 'DAY', 'DEC', 'END', 'EXP', 'FOR', 'GET', 'INT', 'KEY',
      \ 'LAG', 'MAP', 'MAX', 'MIN', 'MOD', 'NEW', 'NOT', 'OLD', 'OUT', 'PAD',
      \ 'REF', 'ROW', 'SET', 'SQL', 'SUM', 'XML', 'BLOB', 'BOTH', 'CALL',
      \ 'CASE', 'CAST', 'CEIL', 'CHAR', 'CLOB', 'CORR', 'CUBE', 'DATA',
      \ 'DATE', 'DESC', 'DROP', 'EACH', 'ELSE', 'EXEC', 'EXIT', 'FREE',
      \ 'FROM', 'FULL', 'GOTO', 'HOLD', 'HOUR', 'INTO', 'JOIN', 'LAST',
      \ 'LEAD', 'LEFT', 'LIKE', 'LOOP', 'NEXT', 'NONE', 'NULL', 'ONLY',
      \ 'OPEN', 'OVER', 'PATH', 'RANK', 'READ', 'REAL', 'ROLE', 'ROWS',
      \ 'SETS', 'SIZE', 'SOME', 'SQRT', 'THEN', 'TIME', 'TRIM', 'TRUE',
      \ 'UNDO', 'USER', 'VIEW', 'WHEN', 'WITH', 'WORK', 'YEAR', 'ZONE',
      \ 'ALTER', 'ARRAY', 'BEGIN', 'CHECK', 'CLOSE', 'COUNT', 'CROSS',
      \ 'CYCLE', 'DEREF', 'EVERY', 'FALSE', 'FETCH', 'FIRST', 'FLOAT',
      \ 'FLOOR', 'FOUND', 'GRANT', 'GROUP', 'INNER', 'INOUT', 'INPUT',
      \ 'LARGE', 'LEVEL', 'LOCAL', 'LOWER', 'MATCH', 'MERGE', 'MONTH',
      \ 'NAMES', 'NCHAR', 'NCLOB', 'NTILE', 'ORDER', 'OUTER', 'POWER',
      \ 'PRIOR', 'RANGE', 'READS', 'RIGHT', 'SCOPE', 'SPACE', 'START',
      \ 'TABLE', 'TREAT', 'UNION', 'UPPER', 'USAGE', 'USING', 'VALUE',
      \ 'WHERE', 'WRITE', 'XMLPI', 'ACTION', 'ATOMIC', 'BIGINT', 'BINARY',
      \ 'CALLED', 'COLUMN', 'COMMIT', 'CREATE', 'CURSOR', 'DELETE', 'DOMAIN',
      \ 'DOUBLE', 'EQUALS', 'ESCAPE', 'EXCEPT', 'EXISTS', 'FILTER', 'FUSION',
      \ 'GLOBAL', 'GROUPS', 'HAVING', 'IMPORT', 'INSERT', 'MEMBER', 'METHOD',
      \ 'MINUTE', 'MODULE', 'NULLIF', 'OFFSET', 'OPTION', 'OUTPUT', 'PERIOD',
      \ 'PUBLIC', 'RESULT', 'RETURN', 'REVOKE', 'ROLLUP', 'SCHEMA', 'SCROLL',
      \ 'SEARCH', 'SECOND', 'SELECT', 'STATIC', 'SYSTEM', 'UNIQUE', 'UNNEST',
      \ 'UPDATE', 'VALUES', 'WINDOW', 'WITHIN', 'XMLAGG', 'BETWEEN',
      \ 'BOOLEAN', 'CASCADE', 'CATALOG', 'CEILING', 'COLLATE', 'COLLECT',
      \ 'CONNECT', 'CONVERT', 'CURRENT', 'DECIMAL', 'DECLARE', 'DEFAULT',
      \ 'DLVALUE', 'DYNAMIC', 'ELEMENT', 'EXECUTE', 'EXTRACT', 'FOREIGN',
      \ 'INTEGER', 'LATERAL', 'LEADING', 'NATURAL', 'NUMERIC', 'OVERLAY',
      \ 'PARTIAL', 'PERCENT', 'PORTION', 'PREPARE', 'PRIMARY', 'REGR_R2',
      \ 'RELEASE', 'RETURNS', 'SECTION', 'SESSION', 'SIMILAR', 'SQLCODE',
      \ 'TRIGGER', 'UESCAPE', 'UNKNOWN', 'VARCHAR', 'VARYING', 'VAR_POP',
      \ 'WITHOUT', 'XMLCAST', 'XMLTEXT', 'ABSOLUTE', 'ALLOCATE', 'CASCADED',
      \ 'COALESCE', 'CONTAINS', 'CONTINUE', 'DATALINK', 'DEFERRED',
      \ 'DESCRIBE', 'DISTINCT', 'END-EXEC', 'EXTERNAL', 'FUNCTION',
      \ 'GROUPING', 'IDENTITY', 'INTERVAL', 'LANGUAGE', 'MODIFIES',
      \ 'MULTISET', 'NATIONAL', 'OVERLAPS', 'POSITION', 'PRECEDES',
      \ 'PRESERVE', 'REGR_SXX', 'REGR_SXY', 'REGR_SYY', 'RELATIVE',
      \ 'RESTRICT', 'ROLLBACK', 'SMALLINT', 'SPECIFIC', 'SQLERROR',
      \ 'SQLSTATE', 'SUCCEEDS', 'TRAILING', 'TRUNCATE', 'VALUE_OF',
      \ 'VAR_SAMP', 'WHENEVER', 'XMLPARSE', 'XMLQUERY', 'XMLTABLE',
      \ 'ARRAY_AGG', 'ASSERTION', 'CHARACTER', 'COLLATION', 'CONDITION',
      \ 'COVAR_POP', 'CUME_DIST', 'DLNEWCOPY', 'DLURLPATH', 'END_FRAME',
      \ 'EXCEPTION', 'FRAME_ROW', 'IMMEDIATE', 'INDICATOR', 'INITIALLY',
      \ 'INTERSECT', 'ISOLATION', 'LOCALTIME', 'NORMALIZE', 'NTH_VALUE',
      \ 'PARAMETER', 'PARTITION', 'PRECISION', 'PROCEDURE', 'RECURSIVE',
      \ 'REGR_AVGX', 'REGR_AVGY', 'SAVEPOINT', 'SENSITIVE', 'SUBSTRING',
      \ 'SYMMETRIC', 'TEMPORARY', 'TIMESTAMP', 'TRANSLATE', 'VARBINARY',
      \ 'XMLBINARY', 'XMLCONCAT', 'XMLEXISTS', 'XMLFOREST', 'ASENSITIVE',
      \ 'ASYMMETRIC', 'BIT_LENGTH', 'CONNECTION', 'CONSTRAINT', 'COVAR_SAMP',
      \ 'DEALLOCATE', 'DEFERRABLE', 'DENSE_RANK', 'DESCRIPTOR', 'DISCONNECT',
      \ 'LAST_VALUE', 'LIKE_REGEX', 'PRIVILEGES', 'REFERENCES', 'REGR_COUNT',
      \ 'REGR_SLOPE', 'ROW_NUMBER', 'SQLWARNING', 'STDDEV_POP', 'TRIM_ARRAY',
      \ 'VERSIONING', 'XMLCOMMENT', 'XMLELEMENT', 'XMLITERATE', 'BEGIN_FRAME',
      \ 'CARDINALITY', 'CHAR_LENGTH', 'CONSTRAINTS', 'CURRENT_ROW',
      \ 'DIAGNOSTICS', 'DLURLSCHEME', 'DLURLSERVER', 'FIRST_VALUE',
      \ 'INSENSITIVE', 'REFERENCING', 'STDDEV_SAMP', 'SUBMULTISET',
      \ 'SYSTEM_TIME', 'SYSTEM_USER', 'TABLESAMPLE', 'TRANSACTION',
      \ 'TRANSLATION', 'XMLDOCUMENT', 'XMLVALIDATE', 'CURRENT_DATE',
      \ 'CURRENT_PATH', 'CURRENT_ROLE', 'CURRENT_TIME', 'CURRENT_USER',
      \ 'INTERSECTION', 'OCTET_LENGTH', 'PERCENT_RANK', 'SESSION_USER',
      \ 'SPECIFICTYPE', 'SQLEXCEPTION', 'WIDTH_BUCKET', 'XMLSERIALIZE',
      \ 'AUTHORIZATION', 'CORRESPONDING', 'DETERMINISTIC', 'DLURLCOMPLETE',
      \ 'DLURLPATHONLY', 'END_PARTITION', 'TIMEZONE_HOUR', 'XMLATTRIBUTES',
      \ 'XMLNAMESPACES', 'CURRENT_SCHEMA', 'DLPREVIOUSCOPY', 'DLURLPATHWRITE',
      \ 'LOCALTIMESTAMP', 'POSITION_REGEX', 'REGR_INTERCEPT',
      \ 'BEGIN_PARTITION', 'CURRENT_CATALOG', 'MAX_CARDINALITY',
      \ 'PERCENTILE_CONT', 'PERCENTILE_DISC', 'SUBSTRING_REGEX',
      \ 'TIMEZONE_MINUTE', 'TRANSLATE_REGEX', 'CHARACTER_LENGTH',
      \ 'CURRENT_TIMESTAMP', 'DLURLCOMPLETEONLY', 'OCCURRENCES_REGEX',
      \ 'DLURLCOMPLETEWRITE', 'ARRAY_MAX_CARDINALITY',
      \ 'CURRENT_DEFAULT_TRANSFORM_GROUP', 'CURRENT_TRANSFORM_GROUP_FOR_TYPE',
      \ ])

if g:SQL_lower2upper_mode ==? 'SQLite'
  " SQLite Keywords
  call s:AddWords([
        \ 'ABORT', 'ACTION', 'ADD', 'AFTER', 'ALL', 'ALTER', 'ANALYZE', 'AND',
        \ 'AS', 'ASC', 'ATTACH', 'AUTOINCREMENT', 'BEFORE', 'BEGIN', 'BETWEEN',
        \ 'BY', 'CASCADE', 'CASE', 'CAST', 'CHECK', 'COLLATE', 'COLUMN',
        \ 'COMMIT', 'CONFLICT', 'CONSTRAINT', 'CREATE', 'CROSS', 'CURRENT_DATE',
        \ 'CURRENT_TIME', 'CURRENT_TIMESTAMP', 'DATABASE', 'DEFAULT',
        \ 'DEFERRABLE', 'DEFERRED', 'DELETE', 'DESC', 'DETACH', 'DISTINCT',
        \ 'DROP', 'EACH', 'ELSE', 'END', 'ESCAPE', 'EXCEPT', 'EXCLUSIVE',
        \ 'EXISTS', 'EXPLAIN', 'FAIL', 'FOR', 'FOREIGN', 'FROM', 'FULL', 'GLOB',
        \ 'GROUP', 'HAVING', 'IF', 'IGNORE', 'IMMEDIATE', 'IN', 'INDEX',
        \ 'INDEXED', 'INITIALLY', 'INNER', 'INSERT', 'INSTEAD', 'INTERSECT',
        \ 'INTO', 'IS', 'ISNULL', 'JOIN', 'KEY', 'LEFT', 'LIKE', 'LIMIT',
        \ 'MATCH', 'NATURAL', 'NO', 'NOT', 'NOTNULL', 'NULL', 'OF', 'OFFSET',
        \ 'ON', 'OR', 'ORDER', 'OUTER', 'PLAN', 'PRAGMA', 'PRIMARY', 'QUERY',
        \ 'RAISE', 'RECURSIVE', 'REFERENCES', 'REGEXP', 'REINDEX', 'RELEASE',
        \ 'RENAME', 'REPLACE', 'RESTRICT', 'RIGHT', 'ROLLBACK', 'ROW',
        \ 'SAVEPOINT', 'SELECT', 'SET', 'TABLE', 'TEMP', 'TEMPORARY', 'THEN',
        \ 'TO', 'TRANSACTION', 'TRIGGER', 'UNION', 'UNIQUE', 'UPDATE', 'USING',
        \ 'VACUUM', 'VALUES', 'VIEW', 'VIRTUAL', 'WHEN', 'WHERE', 'WITH',
        \ 'WITHOUT',
        \ ])
  " SQLite Storage Classes
  call s:AddWords([ 'BLOB', 'INTEGER', 'NULL', 'REAL', 'TEXT' ])
  " SQLite Functions
  call s:AddWords([
        \ 'ABS', 'AVG', 'HEX', 'MAX', 'MAX', 'MIN', 'MIN', 'SUM', 'CHAR',
        \ 'DATE', 'GLOB', 'LIKE', 'LIKE', 'TIME', 'TRIM', 'TRIM', 'COUNT',
        \ 'COUNT', 'INSTR', 'LOWER', 'LTRIM', 'LTRIM', 'QUOTE', 'ROUND',
        \ 'ROUND', 'RTRIM', 'RTRIM', 'TOTAL', 'UPPER', 'IFNULL', 'LENGTH',
        \ 'LIKELY', 'NULLIF', 'PRINTF', 'RANDOM', 'SUBSTR', 'SUBSTR', 'TYPEOF',
        \ 'CHANGES', 'REPLACE', 'SOUNDEX', 'UNICODE', 'COALESCE', 'DATETIME',
        \ 'STRFTIME', 'UNLIKELY', 'ZEROBLOB', 'JULIANDAY', 'LIKELIHOOD',
        \ 'RANDOMBLOB', 'GROUP_CONCAT', 'GROUP_CONCAT', 'TOTAL_CHANGES',
        \ 'LOAD_EXTENSION', 'LOAD_EXTENSION', 'SQLITE_VERSION',
        \ 'SQLITE_SOURCE_ID', 'LAST_INSERT_ROWID', 'SQLITE_COMPILEOPTION_GET',
        \ 'SQLITE_COMPILEOPTION_USED',
        \ ])
endif

" Add user-provided keywords.
if exists('g:SQL_lower2upper_extra_keywords')
      \ && type(g:SQL_lower2upper_extra_keywords) == type([])
  call s:AddWords(g:SQL_lower2upper_extra_keywords)
endif

call uniq(sort(b:SQL_lower2upper_keywords))
call s:Setup(b:SQL_lower2upper_keywords)
imap <buffer> <C-l> <C-R>=<SID>Toggle()<CR>
autocmd InsertLeave <buffer> call <SID>TurnOn()

"vim:tw=78:ts=8:ft=vim:norl:
