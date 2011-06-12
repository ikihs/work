#!ruby -Ku

#$encode = "tosjis"
$encode = "toutf8"

module Lattice

  # lattice("data"=>[[1000,"abcde","12345"],[2000,"fghij","67890"]],
  #          "col"=>[["id",10,""],["key",20,""],["value",20,""]])
  def lattice(a,encode=$encode)
    l = lambda{|i|"+#{i.map{|x,y|"-"*(y+2)}*"+"}+"}
    b = lambda{|i|"| #{i.map{|x,y,z|(x||z).to_s.send($encode).ljust(y)}*" | "} |"}

    line = l.call(a["col"])
    data = a["data"].map{|i|b.call(i.zip(a["col"]).map{|x,y|[x,y[1],y[2]]})}
    data = data - [line.gsub("+","|").gsub("-"," ")]

    [line,b.call(a["col"]),line,data,line].flatten
  end

  def resize_column(h,encode=$encode)
    col = []
    h.flatten.each_slice(2){|i,j|col << [i,j.to_s.send(encode).size]}
    col = col.group_by{|i|i[0]}.map{|j|j[1].max_by{|k|k[1]}}
    col = col.map{|x,y|[x,(y<x.size) ? x.size : y]}
  end

  def lat_grouping a
    a[0..2]+a[3..-2].group_by{|i|i.split[1]}.sort.map{|k,v|[v,a[0]]}.flatten
  end

  def lat_merge *a
    a[0][0..2]+a.reduce([]){|i,j|i+j[3..-2]}+[a[0][-1]]
  end

end


