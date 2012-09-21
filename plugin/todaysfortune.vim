scriptencoding utf-8

function! s:sort(a, b)
  return a:a.rank - a:b.rank
endfunction

function! s:fortune()
  let my_sign = get(g:, 'todaysfortune_my_sign', '')
  let date = strftime("%Y/%m/%d")
  let obj = webapi#json#decode(webapi#http#get("http://api.jugemkey.jp/api/horoscope/free/".date).content)
  let data = sort(obj["horoscope"][date], function("s:sort"))
  for i in range(len(data))
    if my_sign == data[i].sign | echohl Todo | else | echohl Title | endif
    echo printf("%02d位 %s", i+1, data[i].sign)
    echohl None
    echo data[i].content
  endfor
endfunction

command! -nargs=0 TodaysFortune call s:fortune()

