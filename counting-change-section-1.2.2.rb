
def value(c)
  case c
    when 1; then 1
    when 2; then 5
    when 3; then 10
    when 4; then 25
    when 5; then 50
  end
end


def count_the_ways(amt, allowed, saved = {})

  return 1 if amt == 0
  return 0 if amt < 0
  return 0 if allowed == 0

  ways = 0
  
  ways += if saved[ [ amt - value(allowed), allowed]  ]
            saved[ [amt - value(allowed), allowed] ]
          else
            count_the_ways( amt - value(allowed), allowed, saved )
          end

  ways += if saved[ [ amt, allowed - 1 ] ]
            saved[ [ amt, allowed - 1 ] ]
          else
            count_the_ways( amt, allowed - 1, saved )
          end

  saved[ [amt, allowed] ] = ways
  ways
end


value(5)
count_the_ways( 90, 5, {} )


