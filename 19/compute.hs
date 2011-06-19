import Data.List

--September, April, June and November
days_in_month year 4 = 30
days_in_month year 6 = 30
days_in_month year 9 = 30
days_in_month year 11 = 30

days_in_month year 2 = 28

days_in_month year _ = 31


days_in_year year = sum $ map (days_in_month year) [1..12]

main :: IO()
main =  do
    print $ days_in_year 1900
