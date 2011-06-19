import Data.List

days_in_month :: Int -> Int -> Int
--September, April, June and November
days_in_month year 4 = 30
days_in_month year 6 = 30
days_in_month year 9 = 30
days_in_month year 11 = 30

days_in_month year 2 
    | year `mod` 400 == 0 = 29
    | year `mod` 100 == 0 = 28
    | year `mod` 4 == 0 = 29
    | otherwise = 28

days_in_month year _ = 31


days_in_year year = sum $ map (days_in_month year) [1..12]

day_of_week (year, month, day) = ((sum $ map (days_in_year) [1900 .. (year - 1)]) + (sum $ map (days_in_month year) [1 .. (month - 1)]) + (day - 1)) `mod` 7

nextday (year, 12, 31) = (year + 1, 1, 1)
nextday (year, month, day)
        | day < (days_in_month year month) = (year, month, day + 1)
        | day == (days_in_month year month) = (year, month + 1, 1)

only (_, _, day) = day == 1

problem19 day from to = filter ((==day).day_of_week) $ filter (only) $ takeWhile (/=to) $ iterate (nextday) from

main :: IO()
main =  do
    print $ length $ problem19 6 (1901,1,1) (2001,1,1)
