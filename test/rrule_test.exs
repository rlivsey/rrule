defmodule RRuleTest do
  use ExUnit.Case

  use Timex
  import Timex

  doctest RRule

  defp assert_produces(actual, expected) do
    assert actual == expected
  end

  test "before" do
    %RRule{
      freq: :daily,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrence_before(to_datetime({{1997, 9, 5}, {9, 0, 0}}))
    |> assert_produces(to_datetime({{1997, 9, 4}, {9, 0, 0}}))
  end

  test "beforeInc" do
    %RRule{
      freq: :daily,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrence_before(to_datetime({{1997, 9, 5}, {9, 0, 0}}), true)
    |> assert_produces(to_datetime({{1997, 9, 5}, {9, 0, 0}}))
  end

  test "after" do
    %RRule{
      freq: :daily,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrence_after(to_datetime({{1997, 9, 4}, {9, 0, 0}}))
    |> assert_produces(to_datetime({{1997, 9, 5}, {9, 0, 0}}))
  end

  test "afterInc" do
    %RRule{
      freq: :daily,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrence_after(to_datetime({{1997, 9, 4}, {9, 0, 0}}), true)
    |> assert_produces(to_datetime({{1997, 9, 4}, {9, 0, 0}}))
  end

  test "between" do
    %RRule{
      freq: :daily,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences_between(to_datetime({{1997, 9, 2}, {9, 0, 0}}), to_datetime({{1997, 9, 6}, {9, 0, 0}}))
    |> assert_produces([
      to_datetime({{1997, 9, 3}, {9, 0, 0}}),
      to_datetime({{1997, 9, 4}, {9, 0, 0}}),
      to_datetime({{1997, 9, 5}, {9, 0, 0}})
    ])
  end

  test "betweenInc" do
    %RRule{
      freq: :daily,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences_between(to_datetime({{1997, 9, 2}, {9, 0, 0}}), to_datetime({{1997, 9, 6}, {9, 0, 0}}), true)
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 3}, {9, 0, 0}}),
      to_datetime({{1997, 9, 4}, {9, 0, 0}}),
      to_datetime({{1997, 9, 5}, {9, 0, 0}}),
      to_datetime({{1997, 9, 6}, {9, 0, 0}})
    ])
  end

  test "yearly" do
    %RRule{
      freq: :yearly,
      count: 3,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1998, 9, 2}, {9, 0, 0}}),
      to_datetime({{1999, 9, 2}, {9, 0, 0}})
    ])
  end

  test "yearlyInterval" do
    %RRule{
      freq: :yearly,
      count: 3,
      interval: 2,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1999, 9, 2}, {9, 0, 0}}),
      to_datetime({{2001, 9, 2}, {9, 0, 0}})
    ])
  end

  test "yearlyIntervalLarge" do
    %RRule{
      freq: :yearly,
      count: 3,
      interval: 100,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{2097, 9, 2}, {9, 0, 0}}),
      to_datetime({{2197, 9, 2}, {9, 0, 0}})
    ])
  end

  test "yearlyByMonth" do
    %RRule{
      freq: :yearly,
      count: 3,
      bymonth: [1, 3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 2}, {9, 0, 0}}),
      to_datetime({{1998, 3, 2}, {9, 0, 0}}),
      to_datetime({{1999, 1, 2}, {9, 0, 0}})
    ])
  end

  test "yearlyByMonthDay" do
    %RRule{
      freq: :yearly,
      count: 3,
      bymonthday: [1, 3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 3}, {9, 0, 0}}),
      to_datetime({{1997, 10, 1}, {9, 0, 0}}),
      to_datetime({{1997, 10, 3}, {9, 0, 0}})
    ])
  end

  test "yearlyByMonthAndMonthDay" do
    %RRule{
      freq: :yearly,
      count: 3,
      bymonth: [1, 3],
      bymonthday: [5, 7],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 5}, {9, 0, 0}}),
      to_datetime({{1998, 1, 7}, {9, 0, 0}}),
      to_datetime({{1998, 3, 5}, {9, 0, 0}})
    ])
  end

  test "yearlyByWeekDay" do
    %RRule{
      freq: :yearly,
      count: 3,
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 4}, {9, 0, 0}}),
      to_datetime({{1997, 9, 9}, {9, 0, 0}})
    ])
  end

  test "yearlyByNWeekDay" do
    %RRule{
      freq: :yearly,
      count: 3,
      byweekday: [{:tuesday, 1}, {:wednesday, -1}],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 25}, {9, 0, 0}}),
      to_datetime({{1998, 1, 6}, {9, 0, 0}}),
      to_datetime({{1998, 12, 31}, {9, 0, 0}})
    ])
  end

  test "yearlyByNWeekDayLarge" do
    %RRule{
      freq: :yearly,
      count: 3,
      byweekday: [{:tuesday, 3}, {:wednesday, -3}],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 11}, {9, 0, 0}}),
      to_datetime({{1998, 1, 20}, {9, 0, 0}}),
      to_datetime({{1998, 12, 17}, {9, 0, 0}})
    ])
  end

  test "yearlyByMonthAndWeekDay" do
    %RRule{
      freq: :yearly,
      count: 3,
      bymonth: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 1, 6}, {9, 0, 0}}),
      to_datetime({{1998, 1, 8}, {9, 0, 0}})
    ])
  end

  test "yearlyByMonthAndNWeekDay" do
    %RRule{
      freq: :yearly,
      count: 3,
      bymonth: [1, 3],
      byweekday: [{:tuesday, 1}, {:wednesday, -1}],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 6}, {9, 0, 0}}),
      to_datetime({{1998, 1, 29}, {9, 0, 0}}),
      to_datetime({{1998, 3, 3}, {9, 0, 0}})
    ])
  end

  test "yearlyByMonthAndNWeekDayLarge" do
    %RRule{
      freq: :yearly,
      count: 3,
      bymonth: [1, 3],
      byweekday: [{:tuesday, 3}, {:wednesday, -3}],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 15}, {9, 0, 0}}),
      to_datetime({{1998, 1, 20}, {9, 0, 0}}),
      to_datetime({{1998, 3, 12}, {9, 0, 0}})
    ])
  end

  test "yearlyByMonthDayAndWeekDay" do
    %RRule{
      freq: :yearly,
      count: 3,
      bymonthday: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 2, 3}, {9, 0, 0}}),
      to_datetime({{1998, 3, 3}, {9, 0, 0}})
    ])
  end

  test "yearlyByMonthAndMonthDayAndWeekDay" do
    %RRule{
      freq: :yearly,
      count: 3,
      bymonth: [1, 3],
      bymonthday: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 3, 3}, {9, 0, 0}}),
      to_datetime({{2001, 3, 1}, {9, 0, 0}})
    ])
  end

  test "yearlyByYearDay" do
    %RRule{
      freq: :yearly,
      count: 4,
      byyearday: [1, 100, 200, 365],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 31}, {9, 0, 0}}),
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 4, 10}, {9, 0, 0}}),
      to_datetime({{1998, 7, 19}, {9, 0, 0}})
    ])
  end

  test "yearlyByYearDayNeg" do
    %RRule{
      freq: :yearly,
      count: 4,
      byyearday: [-365, -266, -166, -1],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 31}, {9, 0, 0}}),
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 4, 10}, {9, 0, 0}}),
      to_datetime({{1998, 7, 19}, {9, 0, 0}})
    ])
  end

  test "yearlyByMonthAndYearDay" do
    %RRule{
      freq: :yearly,
      count: 4,
      bymonth: [4, 7],
      byyearday: [1, 100, 200, 365],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 10}, {9, 0, 0}}),
      to_datetime({{1998, 7, 19}, {9, 0, 0}}),
      to_datetime({{1999, 4, 10}, {9, 0, 0}}),
      to_datetime({{1999, 7, 19}, {9, 0, 0}})
    ])
  end

  test "yearlyByMonthAndYearDayNeg" do
    %RRule{
      freq: :yearly,
      count: 4,
      bymonth: [4, 7],
      byyearday: [-365, -266, -166, -1],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 10}, {9, 0, 0}}),
      to_datetime({{1998, 7, 19}, {9, 0, 0}}),
      to_datetime({{1999, 4, 10}, {9, 0, 0}}),
      to_datetime({{1999, 7, 19}, {9, 0, 0}})
    ])
  end

  test "yearlyByWeekNo" do
    %RRule{
      freq: :yearly,
      count: 3,
      byweekno: 20,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 5, 11}, {9, 0, 0}}),
      to_datetime({{1998, 5, 12}, {9, 0, 0}}),
      to_datetime({{1998, 5, 13}, {9, 0, 0}})
    ])
  end

  test "yearlyByWeekNoAndWeekDay" do
    # That"s a nice one. The first days of week number one
    # may be in the last year.
    %RRule{
      freq: :yearly,
      count: 3,
      byweekno: 1,
      byweekday: RRule.MO,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 29}, {9, 0, 0}}),
      to_datetime({{1999, 1, 4}, {9, 0, 0}}),
      to_datetime({{2000, 1, 3}, {9, 0, 0}})
    ])
  end

  test "yearlyByWeekNoAndWeekDayLarge" do
    # Another nice test. The last days of week number 52/53
    # may be in the next year.
    %RRule{
      freq: :yearly,
      count: 3,
      byweekno: 52,
      byweekday: :sunday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 28}, {9, 0, 0}}),
      to_datetime({{1998, 12, 27}, {9, 0, 0}}),
      to_datetime({{2000, 1, 2}, {9, 0, 0}})
    ])
  end

  test "yearlyByWeekNoAndWeekDayLast" do
    %RRule{
      freq: :yearly,
      count: 3,
      byweekno: -1,
      byweekday: :sunday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 28}, {9, 0, 0}}),
      to_datetime({{1999, 1, 3}, {9, 0, 0}}),
      to_datetime({{2000, 1, 2}, {9, 0, 0}})
    ])
  end

  test "yearlyByEaster" do
    %RRule{
      freq: :yearly,
      count: 3,
      byeaster: 0,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 12}, {9, 0, 0}}),
      to_datetime({{1999, 4, 4}, {9, 0, 0}}),
      to_datetime({{2000, 4, 23}, {9, 0, 0}})
    ])
  end

  test "yearlyByEasterPos" do
    %RRule{
      freq: :yearly,
      count: 3,
      byeaster: 1,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 13}, {9, 0, 0}}),
      to_datetime({{1999, 4, 5}, {9, 0, 0}}),
      to_datetime({{2000, 4, 24}, {9, 0, 0}})
    ])
  end

  test "yearlyByEasterNeg" do
    %RRule{
      freq: :yearly,
      count: 3,
      byeaster: -1,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 11}, {9, 0, 0}}),
      to_datetime({{1999, 4, 3}, {9, 0, 0}}),
      to_datetime({{2000, 4, 22}, {9, 0, 0}})
    ])
  end

  test "yearlyByWeekNoAndWeekDay53" do
    %RRule{
      freq: :yearly,
      count: 3,
      byweekno: 53,
      byweekday: RRule.MO,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 12, 28}, {9, 0, 0}}),
      to_datetime({{2004, 12, 27}, {9, 0, 0}}),
      to_datetime({{2009, 12, 28}, {9, 0, 0}})
    ])
  end

  test "yearlyByHour" do
    %RRule{
      freq: :yearly,
      count: 3,
      byhour: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 0, 0}}),
      to_datetime({{1998, 9, 2}, {6, 0, 0}}),
      to_datetime({{1998, 9, 2}, {18, 0, 0}})
    ])
  end

  test "yearlyByMinute" do
    %RRule{
      freq: :yearly,
      count: 3,
      byminute: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 6, 0}}),
      to_datetime({{1997, 9, 2}, {9, 18, 0}}),
      to_datetime({{1998, 9, 2}, {9, 6, 0}})
    ])
  end

  test "yearlyBySecond" do
    %RRule{
      freq: :yearly,
      count: 3,
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 6}}),
      to_datetime({{1997, 9, 2}, {9, 0, 18}}),
      to_datetime({{1998, 9, 2}, {9, 0, 6}})
    ])
  end

  test "yearlyByHourAndMinute" do
    %RRule{
      freq: :yearly,
      count: 3,
      byhour: [6, 18],
      byminute: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 6, 0}}),
      to_datetime({{1997, 9, 2}, {18, 18, 0}}),
      to_datetime({{1998, 9, 2}, {6, 6, 0}})
    ])
  end

  test "yearlyByHourAndSecond" do
    %RRule{
      freq: :yearly,
      count: 3,
      byhour: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 0, 6}}),
      to_datetime({{1997, 9, 2}, {18, 0, 18}}),
      to_datetime({{1998, 9, 2}, {6, 0, 6}})
    ])
  end

  test "yearlyByMinuteAndSecond" do
    %RRule{
      freq: :yearly,
      count: 3,
      byminute: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 6, 6}}),
      to_datetime({{1997, 9, 2}, {9, 6, 18}}),
      to_datetime({{1997, 9, 2}, {9, 18, 6}})
    ])
  end

  test "yearlyByHourAndMinuteAndSecond" do
    %RRule{
      freq: :yearly,
      count: 3,
      byhour: [6, 18],
      byminute: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 6, 6}}),
      to_datetime({{1997, 9, 2}, {18, 6, 18}}),
      to_datetime({{1997, 9, 2}, {18, 18, 6}})
    ])
  end

  test "yearlyBySetPos" do
    %RRule{
      freq: :yearly,
      count: 3,
      bymonthday: 15,
      byhour: [6, 18],
      bysetpos: [3, -3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 11, 15}, {18, 0, 0}}),
      to_datetime({{1998, 2, 15}, {6, 0, 0}}),
      to_datetime({{1998, 11, 15}, {18, 0, 0}})
    ])
  end

  test "monthly" do
    %RRule{
      freq: :monthly,
      count: 3,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 10, 2}, {9, 0, 0}}),
      to_datetime({{1997, 11, 2}, {9, 0, 0}})
    ])
  end

  test "monthlyInterval" do
    %RRule{
      freq: :monthly,
      count: 3,
      interval: 2,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 11, 2}, {9, 0, 0}}),
      to_datetime({{1998, 1, 2}, {9, 0, 0}})
    ])
  end

  test "monthlyIntervalLarge" do
    %RRule{
      freq: :monthly,
      count: 3,
      interval: 18,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1999, 3, 2}, {9, 0, 0}}),
      to_datetime({{2000, 9, 2}, {9, 0, 0}})
    ])
  end

  test "monthlyByMonth" do
    %RRule{
      freq: :monthly,
      count: 3,
      bymonth: [1, 3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 2}, {9, 0, 0}}),
      to_datetime({{1998, 3, 2}, {9, 0, 0}}),
      to_datetime({{1999, 1, 2}, {9, 0, 0}})
    ])
  end

  test "monthlyByMonthDay" do
    %RRule{
      freq: :monthly,
      count: 3,
      bymonthday: [1, 3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 3}, {9, 0, 0}}),
      to_datetime({{1997, 10, 1}, {9, 0, 0}}),
      to_datetime({{1997, 10, 3}, {9, 0, 0}})
    ])
  end

  test "monthlyByMonthAndMonthDay" do
    %RRule{
      freq: :monthly,
      count: 3,
      bymonth: [1, 3],
      bymonthday: [5, 7],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 5}, {9, 0, 0}}),
      to_datetime({{1998, 1, 7}, {9, 0, 0}}),
      to_datetime({{1998, 3, 5}, {9, 0, 0}})
    ])
  end

  test "monthlyByWeekDay" do
    %RRule{
      freq: :monthly,
      count: 3,
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 4}, {9, 0, 0}}),
      to_datetime({{1997, 9, 9}, {9, 0, 0}})
    ])
  end

  test "monthlyByNWeekDay" do
    %RRule{
      freq: :monthly,
      count: 3,
      byweekday: [{:tuesday, 1}, {:wednesday, -1}],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 25}, {9, 0, 0}}),
      to_datetime({{1997, 10, 7}, {9, 0, 0}})
    ])
  end

  test "monthlyByNWeekDayLarge" do
    %RRule{
      freq: :monthly,
      count: 3,
      byweekday: [{:tuesday, 3}, {:wednesday, -3}],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 11}, {9, 0, 0}}),
      to_datetime({{1997, 9, 16}, {9, 0, 0}}),
      to_datetime({{1997, 10, 16}, {9, 0, 0}})
    ])
  end

  test "monthlyByMonthAndWeekDay" do
    %RRule{
      freq: :monthly,
      count: 3,
      bymonth: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 1, 6}, {9, 0, 0}}),
      to_datetime({{1998, 1, 8}, {9, 0, 0}})
    ])
  end

  test "monthlyByMonthAndNWeekDay" do
    %RRule{
      freq: :monthly,
      count: 3,
      bymonth: [1, 3],
      byweekday: [{:tuesday, 1}, {:wednesday, -1}],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 6}, {9, 0, 0}}),
      to_datetime({{1998, 1, 29}, {9, 0, 0}}),
      to_datetime({{1998, 3, 3}, {9, 0, 0}})
    ])
  end

  test "monthlyByMonthAndNWeekDayLarge" do
    %RRule{
      freq: :monthly,
      count: 3,
      bymonth: [1, 3],
      byweekday: [{:tuesday, 3}, {:wednesday, -3}],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 15}, {9, 0, 0}}),
      to_datetime({{1998, 1, 20}, {9, 0, 0}}),
      to_datetime({{1998, 3, 12}, {9, 0, 0}})
    ])
  end

  test "monthlyByMonthDayAndWeekDay" do
    %RRule{
      freq: :monthly,
      count: 3,
      bymonthday: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 2, 3}, {9, 0, 0}}),
      to_datetime({{1998, 3, 3}, {9, 0, 0}})
    ])
  end

  test "monthlyByMonthAndMonthDayAndWeekDay" do
    %RRule{
      freq: :monthly,
      count: 3,
      bymonth: [1, 3],
      bymonthday: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 3, 3}, {9, 0, 0}}),
      to_datetime({{2001, 3, 1}, {9, 0, 0}})
    ])
  end

  test "monthlyByYearDay" do
    %RRule{
      freq: :monthly,
      count: 4,
      byyearday: [1, 100, 200, 365],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 31}, {9, 0, 0}}),
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 4, 10}, {9, 0, 0}}),
      to_datetime({{1998, 7, 19}, {9, 0, 0}})
    ])
  end

  test "monthlyByYearDayNeg" do
    %RRule{
      freq: :monthly,
      count: 4,
      byyearday: [-365, -266, -166, -1],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 31}, {9, 0, 0}}),
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 4, 10}, {9, 0, 0}}),
      to_datetime({{1998, 7, 19}, {9, 0, 0}})
    ])
  end

  test "monthlyByMonthAndYearDay" do
    %RRule{
      freq: :monthly,
      count: 4,
      bymonth: [4, 7],
      byyearday: [1, 100, 200, 365],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 10}, {9, 0, 0}}),
      to_datetime({{1998, 7, 19}, {9, 0, 0}}),
      to_datetime({{1999, 4, 10}, {9, 0, 0}}),
      to_datetime({{1999, 7, 19}, {9, 0, 0}})
    ])
  end

  test "monthlyByMonthAndYearDayNeg" do
    %RRule{
      freq: :monthly,
      count: 4,
      bymonth: [4, 7],
      byyearday: [-365, -266, -166, -1],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 10}, {9, 0, 0}}),
      to_datetime({{1998, 7, 19}, {9, 0, 0}}),
      to_datetime({{1999, 4, 10}, {9, 0, 0}}),
      to_datetime({{1999, 7, 19}, {9, 0, 0}})
    ])
  end

  test "monthlyByWeekNo" do
    %RRule{
      freq: :monthly,
      count: 3,
      byweekno: 20,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 5, 11}, {9, 0, 0}}),
      to_datetime({{1998, 5, 12}, {9, 0, 0}}),
      to_datetime({{1998, 5, 13}, {9, 0, 0}})
    ])
  end

  test "monthlyByWeekNoAndWeekDay" do
    # That"s a nice one. The first days of week number one
    # may be in the last year.
    %RRule{
      freq: :monthly,
      count: 3,
      byweekno: 1,
      byweekday: RRule.MO,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 29}, {9, 0, 0}}),
      to_datetime({{1999, 1, 4}, {9, 0, 0}}),
      to_datetime({{2000, 1, 3}, {9, 0, 0}})
    ])
  end

  test "monthlyByWeekNoAndWeekDayLarge" do
    # Another nice test. The last days of week number 52/53
    # may be in the next year.
    %RRule{
      freq: :monthly,
      count: 3,
      byweekno: 52,
      byweekday: :sunday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 28}, {9, 0, 0}}),
      to_datetime({{1998, 12, 27}, {9, 0, 0}}),
      to_datetime({{2000, 1, 2}, {9, 0, 0}})
    ])
  end

  test "monthlyByWeekNoAndWeekDayLast" do
    %RRule{
      freq: :monthly,
      count: 3,
      byweekno: -1,
      byweekday: :sunday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 28}, {9, 0, 0}}),
      to_datetime({{1999, 1, 3}, {9, 0, 0}}),
      to_datetime({{2000, 1, 2}, {9, 0, 0}})
    ])
  end

  test "monthlyByWeekNoAndWeekDay53" do
    %RRule{
      freq: :monthly,
      count: 3,
      byweekno: 53,
      byweekday: RRule.MO,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 12, 28}, {9, 0, 0}}),
      to_datetime({{2004, 12, 27}, {9, 0, 0}}),
      to_datetime({{2009, 12, 28}, {9, 0, 0}})
    ])
  end

  test "monthlyByEaster" do
    %RRule{
      freq: :monthly,
      count: 3,
      byeaster: 0,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 12}, {9, 0, 0}}),
      to_datetime({{1999, 4, 4}, {9, 0, 0}}),
      to_datetime({{2000, 4, 23}, {9, 0, 0}})
    ])
  end

  test "monthlyByEasterPos" do
    %RRule{
      freq: :monthly,
      count: 3,
      byeaster: 1,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 13}, {9, 0, 0}}),
      to_datetime({{1999, 4, 5}, {9, 0, 0}}),
      to_datetime({{2000, 4, 24}, {9, 0, 0}})
    ])
  end

  test "monthlyByEasterNeg" do
    %RRule{
      freq: :monthly,
      count: 3,
      byeaster: -1,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 11}, {9, 0, 0}}),
      to_datetime({{1999, 4, 3}, {9, 0, 0}}),
      to_datetime({{2000, 4, 22}, {9, 0, 0}})
    ])
  end

  test "monthlyByHour" do
    %RRule{
      freq: :monthly,
      count: 3,
      byhour: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 0, 0}}),
      to_datetime({{1997, 10, 2}, {6, 0, 0}}),
      to_datetime({{1997, 10, 2}, {18, 0, 0}})
    ])
  end

  test "monthlyByMinute" do
    %RRule{
      freq: :monthly,
      count: 3,
      byminute: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 6, 0}}),
      to_datetime({{1997, 9, 2}, {9, 18, 0}}),
      to_datetime({{1997, 10, 2}, {9, 6, 0}})
    ])
  end

  test "monthlyBySecond" do
    %RRule{
      freq: :monthly,
      count: 3,
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 6}}),
      to_datetime({{1997, 9, 2}, {9, 0, 18}}),
      to_datetime({{1997, 10, 2}, {9, 0, 6}})
    ])
  end

  test "monthlyByHourAndMinute" do
    %RRule{
      freq: :monthly,
      count: 3,
      byhour: [6, 18],
      byminute: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 6, 0}}),
      to_datetime({{1997, 9, 2}, {18, 18, 0}}),
      to_datetime({{1997, 10, 2}, {6, 6, 0}})
    ])
  end

  test "monthlyByHourAndSecond" do
    %RRule{
      freq: :monthly,
      count: 3,
      byhour: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 0, 6}}),
      to_datetime({{1997, 9, 2}, {18, 0, 18}}),
      to_datetime({{1997, 10, 2}, {6, 0, 6}})
    ])
  end

  test "monthlyByMinuteAndSecond" do
    %RRule{
      freq: :monthly,
      count: 3,
      byminute: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 6, 6}}),
      to_datetime({{1997, 9, 2}, {9, 6, 18}}),
      to_datetime({{1997, 9, 2}, {9, 18, 6}})
    ])
  end

  test "monthlyByHourAndMinuteAndSecond" do
    %RRule{
      freq: :monthly,
      count: 3,
      byhour: [6, 18],
      byminute: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 6, 6}}),
      to_datetime({{1997, 9, 2}, {18, 6, 18}}),
      to_datetime({{1997, 9, 2}, {18, 18, 6}})
    ])
  end

  test "monthlyBySetPos" do
    %RRule{
      freq: :monthly,
      count: 3,
      bymonthday: [13, 17],
      byhour: [6, 18],
      bysetpos: [3, -3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 13}, {18, 0, 0}}),
      to_datetime({{1997, 9, 17}, {6, 0, 0}}),
      to_datetime({{1997, 10, 13}, {18, 0, 0}})
    ])
  end

  test "monthlyNegByMonthDayJanFebForNonLeapYear" do
    %RRule{
      freq: :monthly,
      count: 4,
      bymonthday: -1,
      dtstart: to_datetime({{2013, 12, 1}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{2013, 12, 31}, {9, 0, 0}}),
      to_datetime({{2014, 1, 31}, {9, 0, 0}}),
      to_datetime({{2014, 2, 28}, {9, 0, 0}}),
      to_datetime({{2014, 3, 31}, {9, 0, 0}})
    ])
  end

  test "monthlyNegByMonthDayJanFebForLeapYear" do
    %RRule{
      freq: :monthly,
      count: 4,
      bymonthday: -1,
      dtstart: to_datetime({{2015, 12, 1}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{2015, 12, 31}, {9, 0, 0}}),
      to_datetime({{2016, 1, 31}, {9, 0, 0}}),
      to_datetime({{2016, 2, 29}, {9, 0, 0}}),
      to_datetime({{2016, 3, 31}, {9, 0, 0}})
    ])
  end

  test "weekly" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 9}, {9, 0, 0}}),
      to_datetime({{1997, 9, 16}, {9, 0, 0}})
    ])
  end

  test "weeklyInterval" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      interval: 2,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 16}, {9, 0, 0}}),
      to_datetime({{1997, 9, 30}, {9, 0, 0}})
    ])
  end

  test "weeklyIntervalLarge" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      interval: 20,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1998, 1, 20}, {9, 0, 0}}),
      to_datetime({{1998, 6, 9}, {9, 0, 0}})
    ])
  end

  test "weeklyByMonth" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      bymonth: [1, 3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 6}, {9, 0, 0}}),
      to_datetime({{1998, 1, 13}, {9, 0, 0}}),
      to_datetime({{1998, 1, 20}, {9, 0, 0}})
    ])
  end

  test "weeklyByMonthDay" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      bymonthday: [1, 3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 3}, {9, 0, 0}}),
      to_datetime({{1997, 10, 1}, {9, 0, 0}}),
      to_datetime({{1997, 10, 3}, {9, 0, 0}})
    ])
  end

  test "weeklyByMonthAndMonthDay" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      bymonth: [1, 3],
      bymonthday: [5, 7],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 5}, {9, 0, 0}}),
      to_datetime({{1998, 1, 7}, {9, 0, 0}}),
      to_datetime({{1998, 3, 5}, {9, 0, 0}})
    ])
  end

  test "weeklyByWeekDay" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 4}, {9, 0, 0}}),
      to_datetime({{1997, 9, 9}, {9, 0, 0}})
    ])
  end

  test "weeklyByNWeekDay" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      byweekday: [{:tuesday, 1}, {:wednesday, -1}],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 4}, {9, 0, 0}}),
      to_datetime({{1997, 9, 9}, {9, 0, 0}})
    ])
  end

  test "weeklyByMonthAndWeekDay" do
    # This test is interesting, because it crosses the year
    # boundary in a weekly period to find day "1" as a
    # valid recurrence.
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      bymonth: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 1, 6}, {9, 0, 0}}),
      to_datetime({{1998, 1, 8}, {9, 0, 0}})
    ])
  end

  test "weeklyByMonthAndNWeekDay" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      bymonth: [1, 3],
      byweekday: [{:tuesday, 1}, {:wednesday, -1}],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 1, 6}, {9, 0, 0}}),
      to_datetime({{1998, 1, 8}, {9, 0, 0}})
    ])
  end

  test "weeklyByMonthDayAndWeekDay" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      bymonthday: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 2, 3}, {9, 0, 0}}),
      to_datetime({{1998, 3, 3}, {9, 0, 0}})
    ])
  end

  test "weeklyByMonthAndMonthDayAndWeekDay" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      bymonth: [1, 3],
      bymonthday: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 3, 3}, {9, 0, 0}}),
      to_datetime({{2001, 3, 1}, {9, 0, 0}})
    ])
  end

  test "weeklyByYearDay" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 4,
      byyearday: [1, 100, 200, 365],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 31}, {9, 0, 0}}),
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 4, 10}, {9, 0, 0}}),
      to_datetime({{1998, 7, 19}, {9, 0, 0}})
    ])
  end

  test "weeklyByYearDayNeg" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 4,
      byyearday: [-365, -266, -166, -1],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 31}, {9, 0, 0}}),
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 4, 10}, {9, 0, 0}}),
      to_datetime({{1998, 7, 19}, {9, 0, 0}})
    ])
  end

  test "weeklyByMonthAndYearDay" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 4,
      bymonth: [1, 7],
      byyearday: [1, 100, 200, 365],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 7, 19}, {9, 0, 0}}),
      to_datetime({{1999, 1, 1}, {9, 0, 0}}),
      to_datetime({{1999, 7, 19}, {9, 0, 0}})
    ])
  end

  test "weeklyByMonthAndYearDayNeg" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 4,
      bymonth: [1, 7],
      byyearday: [-365, -266, -166, -1],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 7, 19}, {9, 0, 0}}),
      to_datetime({{1999, 1, 1}, {9, 0, 0}}),
      to_datetime({{1999, 7, 19}, {9, 0, 0}})
    ])
  end

  test "weeklyByWeekNo" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      byweekno: 20,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 5, 11}, {9, 0, 0}}),
      to_datetime({{1998, 5, 12}, {9, 0, 0}}),
      to_datetime({{1998, 5, 13}, {9, 0, 0}})
    ])
  end

  test "weeklyByWeekNoAndWeekDay" do
    # That"s a nice one. The first days of week number one
    # may be in the last year.
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      byweekno: 1,
      byweekday: RRule.MO,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 29}, {9, 0, 0}}),
      to_datetime({{1999, 1, 4}, {9, 0, 0}}),
      to_datetime({{2000, 1, 3}, {9, 0, 0}})
    ])
  end

  test "weeklyByWeekNoAndWeekDayLarge" do
    # Another nice test. The last days of week number 52/53
    # may be in the next year.
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      byweekno: 52,
      byweekday: :sunday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 28}, {9, 0, 0}}),
      to_datetime({{1998, 12, 27}, {9, 0, 0}}),
      to_datetime({{2000, 1, 2}, {9, 0, 0}})
    ])
  end

  test "weeklyByWeekNoAndWeekDayLast" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      byweekno: -1,
      byweekday: :sunday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 28}, {9, 0, 0}}),
      to_datetime({{1999, 1, 3}, {9, 0, 0}}),
      to_datetime({{2000, 1, 2}, {9, 0, 0}})
    ])
  end

  test "weeklyByWeekNoAndWeekDay53" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      byweekno: 53,
      byweekday: RRule.MO,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 12, 28}, {9, 0, 0}}),
      to_datetime({{2004, 12, 27}, {9, 0, 0}}),
      to_datetime({{2009, 12, 28}, {9, 0, 0}})
    ])
  end

  test "weeklyByEaster" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      byeaster: 0,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 12}, {9, 0, 0}}),
      to_datetime({{1999, 4, 4}, {9, 0, 0}}),
      to_datetime({{2000, 4, 23}, {9, 0, 0}})
    ])
  end

  test "weeklyByEasterPos" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      byeaster: 1,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 13}, {9, 0, 0}}),
      to_datetime({{1999, 4, 5}, {9, 0, 0}}),
      to_datetime({{2000, 4, 24}, {9, 0, 0}})
    ])
  end

  test "weeklyByEasterNeg" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      byeaster: -1,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 11}, {9, 0, 0}}),
      to_datetime({{1999, 4, 3}, {9, 0, 0}}),
      to_datetime({{2000, 4, 22}, {9, 0, 0}})
    ])
  end

  test "weeklyByHour" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      byhour: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 0, 0}}),
      to_datetime({{1997, 9, 9}, {6, 0, 0}}),
      to_datetime({{1997, 9, 9}, {18, 0, 0}})
    ])
  end

  test "weeklyByMinute" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      byminute: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 6, 0}}),
      to_datetime({{1997, 9, 2}, {9, 18, 0}}),
      to_datetime({{1997, 9, 9}, {9, 6, 0}})
    ])
  end

  test "weeklyBySecond" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 6}}),
      to_datetime({{1997, 9, 2}, {9, 0, 18}}),
      to_datetime({{1997, 9, 9}, {9, 0, 6}})
    ])
  end

  test "weeklyByHourAndMinute" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      byhour: [6, 18],
      byminute: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 6, 0}}),
      to_datetime({{1997, 9, 2}, {18, 18, 0}}),
      to_datetime({{1997, 9, 9}, {6, 6, 0}})
    ])
  end

  test "weeklyByHourAndSecond" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      byhour: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 0, 6}}),
      to_datetime({{1997, 9, 2}, {18, 0, 18}}),
      to_datetime({{1997, 9, 9}, {6, 0, 6}})
    ])
  end

  test "weeklyByMinuteAndSecond" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      byminute: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 6, 6}}),
      to_datetime({{1997, 9, 2}, {9, 6, 18}}),
      to_datetime({{1997, 9, 2}, {9, 18, 6}})
    ])
  end

  test "weeklyByHourAndMinuteAndSecond" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      byhour: [6, 18],
      byminute: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 6, 6}}),
      to_datetime({{1997, 9, 2}, {18, 6, 18}}),
      to_datetime({{1997, 9, 2}, {18, 18, 6}})
    ])
  end

  test "weeklyBySetPos" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      byweekday: [:tuesday, :wednesday],
      byhour: [6, 18],
      bysetpos: [3, -3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 0, 0}}),
      to_datetime({{1997, 9, 4}, {6, 0, 0}}),
      to_datetime({{1997, 9, 9}, {18, 0, 0}})
    ])
  end

  test "daily" do
    %RRule{
      freq: :daily,
      count: 3,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 3}, {9, 0, 0}}),
      to_datetime({{1997, 9, 4}, {9, 0, 0}})
    ])
  end

  test "dailyInterval" do
    %RRule{
      freq: :daily,
      count: 3,
      interval: 2,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 4}, {9, 0, 0}}),
      to_datetime({{1997, 9, 6}, {9, 0, 0}})
    ])
  end

  test "dailyIntervalLarge" do
    %RRule{
      freq: :daily,
      count: 3,
      interval: 92,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 12, 3}, {9, 0, 0}}),
      to_datetime({{1998, 3, 5}, {9, 0, 0}})
    ])
  end

  test "dailyByMonth" do
    %RRule{
      freq: :daily,
      count: 3,
      bymonth: [1, 3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 1, 2}, {9, 0, 0}}),
      to_datetime({{1998, 1, 3}, {9, 0, 0}})
    ])
  end

  test "dailyByMonthDay" do
    %RRule{
      freq: :daily,
      count: 3,
      bymonthday: [1, 3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 3}, {9, 0, 0}}),
      to_datetime({{1997, 10, 1}, {9, 0, 0}}),
      to_datetime({{1997, 10, 3}, {9, 0, 0}})
    ])
  end

  test "dailyByMonthAndMonthDay" do
    %RRule{
      freq: :daily,
      count: 3,
      bymonth: [1, 3],
      bymonthday: [5, 7],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 5}, {9, 0, 0}}),
      to_datetime({{1998, 1, 7}, {9, 0, 0}}),
      to_datetime({{1998, 3, 5}, {9, 0, 0}})
    ])
  end

  test "dailyByWeekDay" do
    %RRule{
      freq: :daily,
      count: 3,
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 4}, {9, 0, 0}}),
      to_datetime({{1997, 9, 9}, {9, 0, 0}})
    ])
  end

  test "dailyByNWeekDay" do
    %RRule{
      freq: :daily,
      count: 3,
      byweekday: [{:tuesday, 1}, {:wednesday, -1}],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 4}, {9, 0, 0}}),
      to_datetime({{1997, 9, 9}, {9, 0, 0}})
    ])
  end

  test "dailyByMonthAndWeekDay" do
    %RRule{
      freq: :daily,
      count: 3,
      bymonth: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 1, 6}, {9, 0, 0}}),
      to_datetime({{1998, 1, 8}, {9, 0, 0}})
    ])
  end

  test "dailyByMonthAndNWeekDay" do
    %RRule{
      freq: :daily,
      count: 3,
      bymonth: [1, 3],
      byweekday: [{:tuesday, 1}, {:wednesday, -1}],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 1, 6}, {9, 0, 0}}),
      to_datetime({{1998, 1, 8}, {9, 0, 0}})
    ])
  end

  test "dailyByMonthDayAndWeekDay" do
    %RRule{
      freq: :daily,
      count: 3,
      bymonthday: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 2, 3}, {9, 0, 0}}),
      to_datetime({{1998, 3, 3}, {9, 0, 0}})
    ])
  end

  test "dailyByMonthAndMonthDayAndWeekDay" do
    %RRule{
      freq: :daily,
      count: 3,
      bymonth: [1, 3],
      bymonthday: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 3, 3}, {9, 0, 0}}),
      to_datetime({{2001, 3, 1}, {9, 0, 0}})
    ])
  end

  test "dailyByYearDay" do
    %RRule{
      freq: :daily,
      count: 4,
      byyearday: [1, 100, 200, 365],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 31}, {9, 0, 0}}),
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 4, 10}, {9, 0, 0}}),
      to_datetime({{1998, 7, 19}, {9, 0, 0}})
    ])
  end

  test "dailyByYearDayNeg" do
    %RRule{
      freq: :daily,
      count: 4,
      byyearday: [-365, -266, -166, -1],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 31}, {9, 0, 0}}),
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 4, 10}, {9, 0, 0}}),
      to_datetime({{1998, 7, 19}, {9, 0, 0}})
    ])
  end

  test "dailyByMonthAndYearDay" do
    %RRule{
      freq: :daily,
      count: 4,
      bymonth: [1, 7],
      byyearday: [1, 100, 200, 365],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 7, 19}, {9, 0, 0}}),
      to_datetime({{1999, 1, 1}, {9, 0, 0}}),
      to_datetime({{1999, 7, 19}, {9, 0, 0}})
    ])
  end

  test "dailyByMonthAndYearDayNeg" do
    %RRule{
      freq: :daily,
      count: 4,
      bymonth: [1, 7],
      byyearday: [-365, -266, -166, -1],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {9, 0, 0}}),
      to_datetime({{1998, 7, 19}, {9, 0, 0}}),
      to_datetime({{1999, 1, 1}, {9, 0, 0}}),
      to_datetime({{1999, 7, 19}, {9, 0, 0}})
    ])
  end

  test "dailyByWeekNo" do
    %RRule{
      freq: :daily,
      count: 3,
      byweekno: 20,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 5, 11}, {9, 0, 0}}),
      to_datetime({{1998, 5, 12}, {9, 0, 0}}),
      to_datetime({{1998, 5, 13}, {9, 0, 0}})
    ])
  end

  test "dailyByWeekNoAndWeekDay" do
    # That"s a nice one. The first days of week number one
    # may be in the last year.
    %RRule{
      freq: :daily,
      count: 3,
      byweekno: 1,
      byweekday: RRule.MO,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 29}, {9, 0, 0}}),
      to_datetime({{1999, 1, 4}, {9, 0, 0}}),
      to_datetime({{2000, 1, 3}, {9, 0, 0}})
    ])
  end

  test "dailyByWeekNoAndWeekDayLarge" do
    # Another nice test. The last days of week number 52/53
    # may be in the next year.
    %RRule{
      freq: :daily,
      count: 3,
      byweekno: 52,
      byweekday: :sunday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 28}, {9, 0, 0}}),
      to_datetime({{1998, 12, 27}, {9, 0, 0}}),
      to_datetime({{2000, 1, 2}, {9, 0, 0}})
    ])
  end

  test "dailyByWeekNoAndWeekDayLast" do
    %RRule{
      freq: :daily,
      count: 3,
      byweekno: -1,
      byweekday: :sunday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 28}, {9, 0, 0}}),
      to_datetime({{1999, 1, 3}, {9, 0, 0}}),
      to_datetime({{2000, 1, 2}, {9, 0, 0}})
    ])
  end

  test "dailyByWeekNoAndWeekDay53" do
    %RRule{
      freq: :daily,
      count: 3,
      byweekno: 53,
      byweekday: RRule.MO,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 12, 28}, {9, 0, 0}}),
      to_datetime({{2004, 12, 27}, {9, 0, 0}}),
      to_datetime({{2009, 12, 28}, {9, 0, 0}})
    ])
  end

  test "dailyByEaster" do
    %RRule{
      freq: :daily,
      count: 3,
      byeaster: 0,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 12}, {9, 0, 0}}),
      to_datetime({{1999, 4, 4}, {9, 0, 0}}),
      to_datetime({{2000, 4, 23}, {9, 0, 0}})
    ])
  end

  test "dailyByEasterPos" do
    %RRule{
      freq: :daily,
      count: 3,
      byeaster: 1,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 13}, {9, 0, 0}}),
      to_datetime({{1999, 4, 5}, {9, 0, 0}}),
      to_datetime({{2000, 4, 24}, {9, 0, 0}})
    ])
  end

  test "dailyByEasterNeg" do
    %RRule{
      freq: :daily,
      count: 3,
      byeaster: -1,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 11}, {9, 0, 0}}),
      to_datetime({{1999, 4, 3}, {9, 0, 0}}),
      to_datetime({{2000, 4, 22}, {9, 0, 0}})
    ])
  end

  test "dailyByHour" do
    %RRule{
      freq: :daily,
      count: 3,
      byhour: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 0, 0}}),
      to_datetime({{1997, 9, 3}, {6, 0, 0}}),
      to_datetime({{1997, 9, 3}, {18, 0, 0}})
    ])
  end

  test "dailyByMinute" do
    %RRule{
      freq: :daily,
      count: 3,
      byminute: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 6, 0}}),
      to_datetime({{1997, 9, 2}, {9, 18, 0}}),
      to_datetime({{1997, 9, 3}, {9, 6, 0}})
    ])
  end

  test "dailyBySecond" do
    %RRule{
      freq: :daily,
      count: 3,
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 6}}),
      to_datetime({{1997, 9, 2}, {9, 0, 18}}),
      to_datetime({{1997, 9, 3}, {9, 0, 6}})
    ])
  end

  test "dailyByHourAndMinute" do
    %RRule{
      freq: :daily,
      count: 3,
      byhour: [6, 18],
      byminute: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 6, 0}}),
      to_datetime({{1997, 9, 2}, {18, 18, 0}}),
      to_datetime({{1997, 9, 3}, {6, 6, 0}})
    ])
  end

  test "dailyByHourAndSecond" do
    %RRule{
      freq: :daily,
      count: 3,
      byhour: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 0, 6}}),
      to_datetime({{1997, 9, 2}, {18, 0, 18}}),
      to_datetime({{1997, 9, 3}, {6, 0, 6}})
    ])
  end

  test "dailyByMinuteAndSecond" do
    %RRule{
      freq: :daily,
      count: 3,
      byminute: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 6, 6}}),
      to_datetime({{1997, 9, 2}, {9, 6, 18}}),
      to_datetime({{1997, 9, 2}, {9, 18, 6}})
    ])
  end

  test "dailyByHourAndMinuteAndSecond" do
    %RRule{
      freq: :daily,
      count: 3,
      byhour: [6, 18],
      byminute: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 6, 6}}),
      to_datetime({{1997, 9, 2}, {18, 6, 18}}),
      to_datetime({{1997, 9, 2}, {18, 18, 6}})
    ])
  end

  test "dailyBySetPos" do
    %RRule{
      freq: :daily,
      count: 3,
      byhour: [6, 18],
      byminute: [15, 45],
      bysetpos: [3, -3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 15, 0}}),
      to_datetime({{1997, 9, 3}, {6, 45, 0}}),
      to_datetime({{1997, 9, 3}, {18, 15, 0}})
    ])
  end

  test "hourly" do
    %RRule{
      freq: :hourly,
      count: 3,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 2}, {10, 0, 0}}),
      to_datetime({{1997, 9, 2}, {11, 0, 0}})
    ])
  end

  test "hourlyInterval" do
    %RRule{
      freq: :hourly,
      count: 3,
      interval: 2,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 2}, {11, 0, 0}}),
      to_datetime({{1997, 9, 2}, {13, 0, 0}})
    ])
  end

  test "hourlyIntervalLarge" do
    %RRule{
      freq: :hourly,
      count: 3,
      interval: 769,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 10, 4}, {10, 0, 0}}),
      to_datetime({{1997, 11, 5}, {11, 0, 0}})
    ])
  end

  test "hourlyByMonth" do
    %RRule{
      freq: :hourly,
      count: 3,
      bymonth: [1, 3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {0, 0, 0}}),
      to_datetime({{1998, 1, 1}, {1, 0, 0}}),
      to_datetime({{1998, 1, 1}, {2, 0, 0}})
    ])
  end

  test "hourlyByMonthDay" do
    %RRule{
      freq: :hourly,
      count: 3,
      bymonthday: [1, 3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 3}, {0, 0, 0}}),
      to_datetime({{1997, 9, 3}, {1, 0, 0}}),
      to_datetime({{1997, 9, 3}, {2, 0, 0}})
    ])
  end

  test "hourlyByMonthAndMonthDay" do
    %RRule{
      freq: :hourly,
      count: 3,
      bymonth: [1, 3],
      bymonthday: [5, 7],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 5}, {0, 0, 0}}),
      to_datetime({{1998, 1, 5}, {1, 0, 0}}),
      to_datetime({{1998, 1, 5}, {2, 0, 0}})
    ])
  end

  test "hourlyByWeekDay" do
    %RRule{
      freq: :hourly,
      count: 3,
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 2}, {10, 0, 0}}),
      to_datetime({{1997, 9, 2}, {11, 0, 0}})
    ])
  end

  test "hourlyByNWeekDay" do
    %RRule{
      freq: :hourly,
      count: 3,
      byweekday: [{:tuesday, 1}, {:wednesday, -1}],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 2}, {10, 0, 0}}),
      to_datetime({{1997, 9, 2}, {11, 0, 0}})
    ])
  end

  test "hourlyByMonthAndWeekDay" do
    %RRule{
      freq: :hourly,
      count: 3,
      bymonth: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {0, 0, 0}}),
      to_datetime({{1998, 1, 1}, {1, 0, 0}}),
      to_datetime({{1998, 1, 1}, {2, 0, 0}})
    ])
  end

  test "hourlyByMonthAndNWeekDay" do
    %RRule{
      freq: :hourly,
      count: 3,
      bymonth: [1, 3],
      byweekday: [{:tuesday, 1}, {:wednesday, -1}],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {0, 0, 0}}),
      to_datetime({{1998, 1, 1}, {1, 0, 0}}),
      to_datetime({{1998, 1, 1}, {2, 0, 0}})
    ])
  end

  test "hourlyByMonthDayAndWeekDay" do
    %RRule{
      freq: :hourly,
      count: 3,
      bymonthday: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {0, 0, 0}}),
      to_datetime({{1998, 1, 1}, {1, 0, 0}}),
      to_datetime({{1998, 1, 1}, {2, 0, 0}})
    ])
  end

  test "hourlyByMonthAndMonthDayAndWeekDay" do
    %RRule{
      freq: :hourly,
      count: 3,
      bymonth: [1, 3],
      bymonthday: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {0, 0, 0}}),
      to_datetime({{1998, 1, 1}, {1, 0, 0}}),
      to_datetime({{1998, 1, 1}, {2, 0, 0}})
    ])
  end

  test "hourlyByYearDay" do
    %RRule{
      freq: :hourly,
      count: 4,
      byyearday: [1, 100, 200, 365],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 31}, {0, 0, 0}}),
      to_datetime({{1997, 12, 31}, {1, 0, 0}}),
      to_datetime({{1997, 12, 31}, {2, 0, 0}}),
      to_datetime({{1997, 12, 31}, {3, 0, 0}})
    ])
  end

  test "hourlyByYearDayNeg" do
    %RRule{
      freq: :hourly,
      count: 4,
      byyearday: [-365, -266, -166, -1],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 31}, {0, 0, 0}}),
      to_datetime({{1997, 12, 31}, {1, 0, 0}}),
      to_datetime({{1997, 12, 31}, {2, 0, 0}}),
      to_datetime({{1997, 12, 31}, {3, 0, 0}})
    ])
  end

  test "hourlyByMonthAndYearDay" do
    %RRule{
      freq: :hourly,
      count: 4,
      bymonth: [4, 7],
      byyearday: [1, 100, 200, 365],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 10}, {0, 0, 0}}),
      to_datetime({{1998, 4, 10}, {1, 0, 0}}),
      to_datetime({{1998, 4, 10}, {2, 0, 0}}),
      to_datetime({{1998, 4, 10}, {3, 0, 0}})
    ])
  end

  test "hourlyByMonthAndYearDayNeg" do
    %RRule{
      freq: :hourly,
      count: 4,
      bymonth: [4, 7],
      byyearday: [-365, -266, -166, -1],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 10}, {0, 0, 0}}),
      to_datetime({{1998, 4, 10}, {1, 0, 0}}),
      to_datetime({{1998, 4, 10}, {2, 0, 0}}),
      to_datetime({{1998, 4, 10}, {3, 0, 0}})
    ])
  end

  test "hourlyByWeekNo" do
    %RRule{
      freq: :hourly,
      count: 3,
      byweekno: 20,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 5, 11}, {0, 0, 0}}),
      to_datetime({{1998, 5, 11}, {1, 0, 0}}),
      to_datetime({{1998, 5, 11}, {2, 0, 0}})
    ])
  end

  test "hourlyByWeekNoAndWeekDay" do
    %RRule{
      freq: :hourly,
      count: 3,
      byweekno: 1,
      byweekday: RRule.MO,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 29}, {0, 0, 0}}),
      to_datetime({{1997, 12, 29}, {1, 0, 0}}),
      to_datetime({{1997, 12, 29}, {2, 0, 0}})
    ])
  end

  test "hourlyByWeekNoAndWeekDayLarge" do
    %RRule{
      freq: :hourly,
      count: 3,
      byweekno: 52,
      byweekday: :sunday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 28}, {0, 0, 0}}),
      to_datetime({{1997, 12, 28}, {1, 0, 0}}),
      to_datetime({{1997, 12, 28}, {2, 0, 0}})
    ])
  end

  test "hourlyByWeekNoAndWeekDayLast" do
    %RRule{
      freq: :hourly,
      count: 3,
      byweekno: -1,
      byweekday: :sunday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 28}, {0, 0, 0}}),
      to_datetime({{1997, 12, 28}, {1, 0, 0}}),
      to_datetime({{1997, 12, 28}, {2, 0, 0}})
    ])
  end

  test "hourlyByWeekNoAndWeekDay53" do
    %RRule{
      freq: :hourly,
      count: 3,
      byweekno: 53,
      byweekday: RRule.MO,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 12, 28}, {0, 0, 0}}),
      to_datetime({{1998, 12, 28}, {1, 0, 0}}),
      to_datetime({{1998, 12, 28}, {2, 0, 0}})
    ])
  end

  @tag :skip
  test "testHourlyByEaster" do
    %RRule{
      freq: :hourly,
      count: 3,
      byeaster: 0,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 12}, {0, 0, 0}}),
      to_datetime({{1998, 4, 12}, {1, 0, 0}}),
      to_datetime({{1998, 4, 12}, {2, 0, 0}})
    ])
  end

  @tag :skip
  test "testHourlyByEasterPos" do
    %RRule{
      freq: :hourly,
      count: 3,
      byeaster: 1,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 13}, {0, 0, 0}}),
      to_datetime({{1998, 4, 13}, {1, 0, 0}}),
      to_datetime({{1998, 4, 13}, {2, 0, 0}})
    ])
  end

  @tag :skip
  test "testHourlyByEasterNeg" do
    %RRule{
      freq: :hourly,
      count: 3,
      byeaster: -1,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 11}, {0, 0, 0}}),
      to_datetime({{1998, 4, 11}, {1, 0, 0}}),
      to_datetime({{1998, 4, 11}, {2, 0, 0}})
    ])
  end

  test "hourlyByHour" do
    %RRule{
      freq: :hourly,
      count: 3,
      byhour: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 0, 0}}),
      to_datetime({{1997, 9, 3}, {6, 0, 0}}),
      to_datetime({{1997, 9, 3}, {18, 0, 0}})
    ])
  end

  test "hourlyByMinute" do
    %RRule{
      freq: :hourly,
      count: 3,
      byminute: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 6, 0}}),
      to_datetime({{1997, 9, 2}, {9, 18, 0}}),
      to_datetime({{1997, 9, 2}, {10, 6, 0}})
    ])
  end

  test "hourlyBySecond" do
    %RRule{
      freq: :hourly,
      count: 3,
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 6}}),
      to_datetime({{1997, 9, 2}, {9, 0, 18}}),
      to_datetime({{1997, 9, 2}, {10, 0, 6}})
    ])
  end

  test "hourlyByHourAndMinute" do
    %RRule{
      freq: :hourly,
      count: 3,
      byhour: [6, 18],
      byminute: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 6, 0}}),
      to_datetime({{1997, 9, 2}, {18, 18, 0}}),
      to_datetime({{1997, 9, 3}, {6, 6, 0}})
    ])
  end

  test "hourlyByHourAndSecond" do
    %RRule{
      freq: :hourly,
      count: 3,
      byhour: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 0, 6}}),
      to_datetime({{1997, 9, 2}, {18, 0, 18}}),
      to_datetime({{1997, 9, 3}, {6, 0, 6}})
    ])
  end

  test "hourlyByMinuteAndSecond" do
    %RRule{
      freq: :hourly,
      count: 3,
      byminute: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 6, 6}}),
      to_datetime({{1997, 9, 2}, {9, 6, 18}}),
      to_datetime({{1997, 9, 2}, {9, 18, 6}})
    ])
  end

  test "hourlyByHourAndMinuteAndSecond" do
    %RRule{
      freq: :hourly,
      count: 3,
      byhour: [6, 18],
      byminute: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 6, 6}}),
      to_datetime({{1997, 9, 2}, {18, 6, 18}}),
      to_datetime({{1997, 9, 2}, {18, 18, 6}})
    ])
  end

  test "hourlyBySetPos" do
    %RRule{
      freq: :hourly,
      count: 3,
      byminute: [15, 45],
      bysecond: [15, 45],
      bysetpos: [3, -3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 15, 45}}),
      to_datetime({{1997, 9, 2}, {9, 45, 15}}),
      to_datetime({{1997, 9, 2}, {10, 15, 45}})
    ])
  end

  test "minutely" do
    %RRule{
      freq: :minutely,
      count: 3,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 2}, {9, 1, 0}}),
      to_datetime({{1997, 9, 2}, {9, 2, 0}})
    ])
  end

  test "minutelyInterval" do
    %RRule{
      freq: :minutely,
      count: 3,
      interval: 2,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 2}, {9, 2, 0}}),
      to_datetime({{1997, 9, 2}, {9, 4, 0}})
    ])
  end

  test "minutelyIntervalLarge" do
    %RRule{
      freq: :minutely,
      count: 3,
      interval: 1501,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 3}, {10, 1, 0}}),
      to_datetime({{1997, 9, 4}, {11, 2, 0}})
    ])
  end

  test "minutelyByMonth" do
    %RRule{
      freq: :minutely,
      count: 3,
      bymonth: [1, 3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {0, 0, 0}}),
      to_datetime({{1998, 1, 1}, {0, 1, 0}}),
      to_datetime({{1998, 1, 1}, {0, 2, 0}})
    ])
  end

  test "minutelyByMonthDay" do
    %RRule{
      freq: :minutely,
      count: 3,
      bymonthday: [1, 3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 3}, {0, 0, 0}}),
      to_datetime({{1997, 9, 3}, {0, 1, 0}}),
      to_datetime({{1997, 9, 3}, {0, 2, 0}})
    ])
  end

  test "minutelyByMonthAndMonthDay" do
    %RRule{
      freq: :minutely,
      count: 3,
      bymonth: [1, 3],
      bymonthday: [5, 7],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 5}, {0, 0, 0}}),
      to_datetime({{1998, 1, 5}, {0, 1, 0}}),
      to_datetime({{1998, 1, 5}, {0, 2, 0}})
    ])
  end

  test "minutelyByWeekDay" do
    %RRule{
      freq: :minutely,
      count: 3,
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 2}, {9, 1, 0}}),
      to_datetime({{1997, 9, 2}, {9, 2, 0}})
    ])
  end

  test "minutelyByNWeekDay" do
    %RRule{
      freq: :minutely,
      count: 3,
      byweekday: [{:tuesday, 1}, {:wednesday, -1}],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 2}, {9, 1, 0}}),
      to_datetime({{1997, 9, 2}, {9, 2, 0}})
    ])
  end

  test "minutelyByMonthAndWeekDay" do
    %RRule{
      freq: :minutely,
      count: 3,
      bymonth: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {0, 0, 0}}),
      to_datetime({{1998, 1, 1}, {0, 1, 0}}),
      to_datetime({{1998, 1, 1}, {0, 2, 0}})
    ])
  end

  test "minutelyByMonthAndNWeekDay" do
    %RRule{
      freq: :minutely,
      count: 3,
      bymonth: [1, 3],
      byweekday: [{:tuesday, 1}, {:wednesday, -1}],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {0, 0, 0}}),
      to_datetime({{1998, 1, 1}, {0, 1, 0}}),
      to_datetime({{1998, 1, 1}, {0, 2, 0}})
    ])
  end

  test "minutelyByMonthDayAndWeekDay" do
    %RRule{
      freq: :minutely,
      count: 3,
      bymonthday: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {0, 0, 0}}),
      to_datetime({{1998, 1, 1}, {0, 1, 0}}),
      to_datetime({{1998, 1, 1}, {0, 2, 0}})
    ])
  end

  test "minutelyByMonthAndMonthDayAndWeekDay" do
    %RRule{
      freq: :minutely,
      count: 3,
      bymonth: [1, 3],
      bymonthday: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {0, 0, 0}}),
      to_datetime({{1998, 1, 1}, {0, 1, 0}}),
      to_datetime({{1998, 1, 1}, {0, 2, 0}})
    ])
  end

  test "minutelyByYearDay" do
    %RRule{
      freq: :minutely,
      count: 4,
      byyearday: [1, 100, 200, 365],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 31}, {0, 0, 0}}),
      to_datetime({{1997, 12, 31}, {0, 1, 0}}),
      to_datetime({{1997, 12, 31}, {0, 2, 0}}),
      to_datetime({{1997, 12, 31}, {0, 3, 0}})
    ])
  end

  test "minutelyByYearDayNeg" do
    %RRule{
      freq: :minutely,
      count: 4,
      byyearday: [-365, -266, -166, -1],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 31}, {0, 0, 0}}),
      to_datetime({{1997, 12, 31}, {0, 1, 0}}),
      to_datetime({{1997, 12, 31}, {0, 2, 0}}),
      to_datetime({{1997, 12, 31}, {0, 3, 0}})
    ])
  end

  test "minutelyByMonthAndYearDay" do
    %RRule{
      freq: :minutely,
      count: 4,
      bymonth: [4, 7],
      byyearday: [1, 100, 200, 365],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 10}, {0, 0, 0}}),
      to_datetime({{1998, 4, 10}, {0, 1, 0}}),
      to_datetime({{1998, 4, 10}, {0, 2, 0}}),
      to_datetime({{1998, 4, 10}, {0, 3, 0}})
    ])
  end

  test "minutelyByMonthAndYearDayNeg" do
    %RRule{
      freq: :minutely,
      count: 4,
      bymonth: [4, 7],
      byyearday: [-365, -266, -166, -1],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 10}, {0, 0, 0}}),
      to_datetime({{1998, 4, 10}, {0, 1, 0}}),
      to_datetime({{1998, 4, 10}, {0, 2, 0}}),
      to_datetime({{1998, 4, 10}, {0, 3, 0}})
    ])
  end

  test "minutelyByWeekNo" do
    %RRule{
      freq: :minutely,
      count: 3,
      byweekno: 20,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 5, 11}, {0, 0, 0}}),
      to_datetime({{1998, 5, 11}, {0, 1, 0}}),
      to_datetime({{1998, 5, 11}, {0, 2, 0}})
    ])
  end

  test "minutelyByWeekNoAndWeekDay" do
    %RRule{
      freq: :minutely,
      count: 3,
      byweekno: 1,
      byweekday: RRule.MO,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 29}, {0, 0, 0}}),
      to_datetime({{1997, 12, 29}, {0, 1, 0}}),
      to_datetime({{1997, 12, 29}, {0, 2, 0}})
    ])
  end

  test "minutelyByWeekNoAndWeekDayLarge" do
    %RRule{
      freq: :minutely,
      count: 3,
      byweekno: 52,
      byweekday: :sunday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 28}, {0, 0, 0}}),
      to_datetime({{1997, 12, 28}, {0, 1, 0}}),
      to_datetime({{1997, 12, 28}, {0, 2, 0}})
    ])
  end

  test "minutelyByWeekNoAndWeekDayLast" do
    %RRule{
      freq: :minutely,
      count: 3,
      byweekno: -1,
      byweekday: :sunday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 28}, {0, 0, 0}}),
      to_datetime({{1997, 12, 28}, {0, 1, 0}}),
      to_datetime({{1997, 12, 28}, {0, 2, 0}})
    ])
  end

  test "minutelyByWeekNoAndWeekDay53" do
    %RRule{
      freq: :minutely,
      count: 3,
      byweekno: 53,
      byweekday: RRule.MO,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 12, 28}, {0, 0, 0}}),
      to_datetime({{1998, 12, 28}, {0, 1, 0}}),
      to_datetime({{1998, 12, 28}, {0, 2, 0}})
    ])
  end

  @tag :skip
  test "testMinutelyByEaster" do
    %RRule{
      freq: :minutely,
      count: 3,
      byeaster: 0,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 12}, {0, 0, 0}}),
      to_datetime({{1998, 4, 12}, {0, 1, 0}}),
      to_datetime({{1998, 4, 12}, {0, 2, 0}})
    ])
  end

  @tag :skip
  test "testMinutelyByEasterPos" do
    %RRule{
      freq: :minutely,
      count: 3,
      byeaster: 1,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 13}, {0, 0, 0}}),
      to_datetime({{1998, 4, 13}, {0, 1, 0}}),
      to_datetime({{1998, 4, 13}, {0, 2, 0}})
    ])
  end

  @tag :skip
  test "testMinutelyByEasterNeg" do
    %RRule{
      freq: :minutely,
      count: 3,
      byeaster: -1,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 11}, {0, 0, 0}}),
      to_datetime({{1998, 4, 11}, {0, 1, 0}}),
      to_datetime({{1998, 4, 11}, {0, 2, 0}})
    ])
  end

  test "minutelyByHour" do
    %RRule{
      freq: :minutely,
      count: 3,
      byhour: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 0, 0}}),
      to_datetime({{1997, 9, 2}, {18, 1, 0}}),
      to_datetime({{1997, 9, 2}, {18, 2, 0}})
    ])
  end

  test "minutelyByMinute" do
    %RRule{
      freq: :minutely,
      count: 3,
      byminute: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 6, 0}}),
      to_datetime({{1997, 9, 2}, {9, 18, 0}}),
      to_datetime({{1997, 9, 2}, {10, 6, 0}})
    ])
  end

  test "minutelyBySecond" do
    %RRule{
      freq: :minutely,
      count: 3,
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 6}}),
      to_datetime({{1997, 9, 2}, {9, 0, 18}}),
      to_datetime({{1997, 9, 2}, {9, 1, 6}})
    ])
  end

  test "minutelyByHourAndMinute" do
    %RRule{
      freq: :minutely,
      count: 3,
      byhour: [6, 18],
      byminute: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 6, 0}}),
      to_datetime({{1997, 9, 2}, {18, 18, 0}}),
      to_datetime({{1997, 9, 3}, {6, 6, 0}})
    ])
  end

  test "minutelyByHourAndSecond" do
    %RRule{
      freq: :minutely,
      count: 3,
      byhour: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 0, 6}}),
      to_datetime({{1997, 9, 2}, {18, 0, 18}}),
      to_datetime({{1997, 9, 2}, {18, 1, 6}})
    ])
  end

  test "minutelyByMinuteAndSecond" do
    %RRule{
      freq: :minutely,
      count: 3,
      byminute: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 6, 6}}),
      to_datetime({{1997, 9, 2}, {9, 6, 18}}),
      to_datetime({{1997, 9, 2}, {9, 18, 6}})
    ])
  end

  test "minutelyByHourAndMinuteAndSecond" do
    %RRule{
      freq: :minutely,
      count: 3,
      byhour: [6, 18],
      byminute: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 6, 6}}),
      to_datetime({{1997, 9, 2}, {18, 6, 18}}),
      to_datetime({{1997, 9, 2}, {18, 18, 6}})
    ])
  end

  test "minutelyBySetPos" do
    %RRule{
      freq: :minutely,
      count: 3,
      bysecond: [15, 30, 45],
      bysetpos: [3, -3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 15}}),
      to_datetime({{1997, 9, 2}, {9, 0, 45}}),
      to_datetime({{1997, 9, 2}, {9, 1, 15}})
    ])
  end

  test "secondly" do
    %RRule{
      freq: :secondly,
      count: 3,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 2}, {9, 0, 1}}),
      to_datetime({{1997, 9, 2}, {9, 0, 2}})
    ])
  end

  test "secondlyInterval" do
    %RRule{
      freq: :secondly,
      count: 3,
      interval: 2,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 2}, {9, 0, 2}}),
      to_datetime({{1997, 9, 2}, {9, 0, 4}})
    ])
  end

  test "secondlyIntervalLarge" do
    %RRule{
      freq: :secondly,
      count: 3,
      interval: 90061,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 3}, {10, 1, 1}}),
      to_datetime({{1997, 9, 4}, {11, 2, 2}})
    ])
  end

  test "secondlyByMonth" do
    %RRule{
      freq: :secondly,
      count: 3,
      bymonth: [1, 3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {0, 0, 0}}),
      to_datetime({{1998, 1, 1}, {0, 0, 1}}),
      to_datetime({{1998, 1, 1}, {0, 0, 2}})
    ])
  end

  test "secondlyByMonthDay" do
    %RRule{
      freq: :secondly,
      count: 3,
      bymonthday: [1, 3],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 3}, {0, 0, 0}}),
      to_datetime({{1997, 9, 3}, {0, 0, 1}}),
      to_datetime({{1997, 9, 3}, {0, 0, 2}})
    ])
  end

  test "secondlyByMonthAndMonthDay" do
    %RRule{
      freq: :secondly,
      count: 3,
      bymonth: [1, 3],
      bymonthday: [5, 7],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 5}, {0, 0, 0}}),
      to_datetime({{1998, 1, 5}, {0, 0, 1}}),
      to_datetime({{1998, 1, 5}, {0, 0, 2}})
    ])
  end

  test "secondlyByWeekDay" do
    %RRule{
      freq: :secondly,
      count: 3,
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 2}, {9, 0, 1}}),
      to_datetime({{1997, 9, 2}, {9, 0, 2}})
    ])
  end

  test "secondlyByNWeekDay" do
    %RRule{
      freq: :secondly,
      count: 3,
      byweekday: [{:tuesday, 1}, {:wednesday, -1}],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 2}, {9, 0, 1}}),
      to_datetime({{1997, 9, 2}, {9, 0, 2}})
    ])
  end

  test "secondlyByMonthAndWeekDay" do
    %RRule{
      freq: :secondly,
      count: 3,
      bymonth: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {0, 0, 0}}),
      to_datetime({{1998, 1, 1}, {0, 0, 1}}),
      to_datetime({{1998, 1, 1}, {0, 0, 2}})
    ])
  end

  test "secondlyByMonthAndNWeekDay" do
    %RRule{
      freq: :secondly,
      count: 3,
      bymonth: [1, 3],
      byweekday: [{:tuesday, 1}, {:wednesday, -1}],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {0, 0, 0}}),
      to_datetime({{1998, 1, 1}, {0, 0, 1}}),
      to_datetime({{1998, 1, 1}, {0, 0, 2}})
    ])
  end

  test "secondlyByMonthDayAndWeekDay" do
    %RRule{
      freq: :secondly,
      count: 3,
      bymonthday: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {0, 0, 0}}),
      to_datetime({{1998, 1, 1}, {0, 0, 1}}),
      to_datetime({{1998, 1, 1}, {0, 0, 2}})
    ])
  end

  test "secondlyByMonthAndMonthDayAndWeekDay" do
    %RRule{
      freq: :secondly,
      count: 3,
      bymonth: [1, 3],
      bymonthday: [1, 3],
      byweekday: [:tuesday, :wednesday],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 1, 1}, {0, 0, 0}}),
      to_datetime({{1998, 1, 1}, {0, 0, 1}}),
      to_datetime({{1998, 1, 1}, {0, 0, 2}})
    ])
  end

  test "secondlyByYearDay" do
    %RRule{
      freq: :secondly,
      count: 4,
      byyearday: [1, 100, 200, 365],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 31}, {0, 0, 0}}),
      to_datetime({{1997, 12, 31}, {0, 0, 1}}),
      to_datetime({{1997, 12, 31}, {0, 0, 2}}),
      to_datetime({{1997, 12, 31}, {0, 0, 3}})
    ])
  end

  test "secondlyByYearDayNeg" do
    %RRule{
      freq: :secondly,
      count: 4,
      byyearday: [-365, -266, -166, -1],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 31}, {0, 0, 0}}),
      to_datetime({{1997, 12, 31}, {0, 0, 1}}),
      to_datetime({{1997, 12, 31}, {0, 0, 2}}),
      to_datetime({{1997, 12, 31}, {0, 0, 3}})
    ])
  end

  test "secondlyByMonthAndYearDay" do
    %RRule{
      freq: :secondly,
      count: 4,
      bymonth: [4, 7],
      byyearday: [1, 100, 200, 365],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 10}, {0, 0, 0}}),
      to_datetime({{1998, 4, 10}, {0, 0, 1}}),
      to_datetime({{1998, 4, 10}, {0, 0, 2}}),
      to_datetime({{1998, 4, 10}, {0, 0, 3}})
    ])
  end

  test "secondlyByMonthAndYearDayNeg" do
    %RRule{
      freq: :secondly,
      count: 4,
      bymonth: [4, 7],
      byyearday: [-365, -266, -166, -1],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 10}, {0, 0, 0}}),
      to_datetime({{1998, 4, 10}, {0, 0, 1}}),
      to_datetime({{1998, 4, 10}, {0, 0, 2}}),
      to_datetime({{1998, 4, 10}, {0, 0, 3}})
    ])
  end

  test "secondlyByWeekNo" do
    %RRule{
      freq: :secondly,
      count: 3,
      byweekno: 20,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 5, 11}, {0, 0, 0}}),
      to_datetime({{1998, 5, 11}, {0, 0, 1}}),
      to_datetime({{1998, 5, 11}, {0, 0, 2}})
    ])
  end

  test "secondlyByWeekNoAndWeekDay" do
    %RRule{
      freq: :secondly,
      count: 3,
      byweekno: 1,
      byweekday: RRule.MO,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 29}, {0, 0, 0}}),
      to_datetime({{1997, 12, 29}, {0, 0, 1}}),
      to_datetime({{1997, 12, 29}, {0, 0, 2}})
    ])
  end

  test "secondlyByWeekNoAndWeekDayLarge" do
    %RRule{
      freq: :secondly,
      count: 3,
      byweekno: 52,
      byweekday: :sunday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 28}, {0, 0, 0}}),
      to_datetime({{1997, 12, 28}, {0, 0, 1}}),
      to_datetime({{1997, 12, 28}, {0, 0, 2}})
    ])
  end

  test "secondlyByWeekNoAndWeekDayLast" do
    %RRule{
      freq: :secondly,
      count: 3,
      byweekno: -1,
      byweekday: :sunday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 28}, {0, 0, 0}}),
      to_datetime({{1997, 12, 28}, {0, 0, 1}}),
      to_datetime({{1997, 12, 28}, {0, 0, 2}})
    ])
  end

  test "secondlyByWeekNoAndWeekDay53" do
    %RRule{
      freq: :secondly,
      count: 3,
      byweekno: 53,
      byweekday: RRule.MO,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 12, 28}, {0, 0, 0}}),
      to_datetime({{1998, 12, 28}, {0, 0, 1}}),
      to_datetime({{1998, 12, 28}, {0, 0, 2}})
    ])
  end

  @tag :skip
  test "testSecondlyByEaster" do
    %RRule{
      freq: :secondly,
      count: 3,
      byeaster: 0,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 12}, {0, 0, 0}}),
      to_datetime({{1998, 4, 12}, {0, 0, 1}}),
      to_datetime({{1998, 4, 12}, {0, 0, 2}})
    ])
  end

  @tag :skip
  test "testSecondlyByEasterPos" do
    %RRule{
      freq: :secondly,
      count: 3,
      byeaster: 1,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 13}, {0, 0, 0}}),
      to_datetime({{1998, 4, 13}, {0, 0, 1}}),
      to_datetime({{1998, 4, 13}, {0, 0, 2}})
    ])
  end

  @tag :skip
  test "testSecondlyByEasterNeg" do
    %RRule{
      freq: :secondly,
      count: 3,
      byeaster: -1,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 4, 11}, {0, 0, 0}}),
      to_datetime({{1998, 4, 11}, {0, 0, 1}}),
      to_datetime({{1998, 4, 11}, {0, 0, 2}})
    ])
  end

  test "secondlyByHour" do
    %RRule{
      freq: :secondly,
      count: 3,
      byhour: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 0, 0}}),
      to_datetime({{1997, 9, 2}, {18, 0, 1}}),
      to_datetime({{1997, 9, 2}, {18, 0, 2}})
    ])
  end

  test "secondlyByMinute" do
    %RRule{
      freq: :secondly,
      count: 3,
      byminute: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 6, 0}}),
      to_datetime({{1997, 9, 2}, {9, 6, 1}}),
      to_datetime({{1997, 9, 2}, {9, 6, 2}})
    ])
  end

  test "secondlyBySecond" do
    %RRule{
      freq: :secondly,
      count: 3,
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 6}}),
      to_datetime({{1997, 9, 2}, {9, 0, 18}}),
      to_datetime({{1997, 9, 2}, {9, 1, 6}})
    ])
  end

  test "secondlyByHourAndMinute" do
    %RRule{
      freq: :secondly,
      count: 3,
      byhour: [6, 18],
      byminute: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 6, 0}}),
      to_datetime({{1997, 9, 2}, {18, 6, 1}}),
      to_datetime({{1997, 9, 2}, {18, 6, 2}})
    ])
  end

  test "secondlyByHourAndSecond" do
    %RRule{
      freq: :secondly,
      count: 3,
      byhour: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 0, 6}}),
      to_datetime({{1997, 9, 2}, {18, 0, 18}}),
      to_datetime({{1997, 9, 2}, {18, 1, 6}})
    ])
  end

  test "secondlyByMinuteAndSecond" do
    %RRule{
      freq: :secondly,
      count: 3,
      byminute: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 6, 6}}),
      to_datetime({{1997, 9, 2}, {9, 6, 18}}),
      to_datetime({{1997, 9, 2}, {9, 18, 6}})
    ])
  end

  test "secondlyByHourAndMinuteAndSecond" do
    %RRule{
      freq: :secondly,
      count: 3,
      byhour: [6, 18],
      byminute: [6, 18],
      bysecond: [6, 18],
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {18, 6, 6}}),
      to_datetime({{1997, 9, 2}, {18, 6, 18}}),
      to_datetime({{1997, 9, 2}, {18, 18, 6}})
    ])
  end

  test "untilNotMatching" do
    %RRule{
      freq: :daily,
      count: 3,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      until: to_datetime({{1997, 9, 5}, {8, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 3}, {9, 0, 0}}),
      to_datetime({{1997, 9, 4}, {9, 0, 0}})
    ])
  end

  test "untilMatching" do
    %RRule{
      freq: :daily,
      count: 3,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      until: to_datetime({{1997, 9, 4}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 3}, {9, 0, 0}}),
      to_datetime({{1997, 9, 4}, {9, 0, 0}})
    ])
  end

  test "untilSingle" do
    %RRule{
      freq: :daily,
      count: 3,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      until: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}})
    ])
  end

  test "untilEmpty" do
    %RRule{
      freq: :daily,
      count: 3,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      until: to_datetime({{1997, 9, 1}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([])
  end

  test "untilWithDate" do
    %RRule{
      freq: :daily,
      count: 3,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      until: to_date({1997, 9, 5})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 3}, {9, 0, 0}}),
      to_datetime({{1997, 9, 4}, {9, 0, 0}})
    ])
  end

  test "wkStIntervalMO" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      interval: 2,
      byweekday: [:tuesday, :sunday],
      wkst: RRule.MO,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 7}, {9, 0, 0}}),
      to_datetime({{1997, 9, 16}, {9, 0, 0}})
    ])
  end

  test "wkStIntervalSU" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      interval: 2,
      byweekday: [:tuesday, :sunday],
      wkst: :sunday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 14}, {9, 0, 0}}),
      to_datetime({{1997, 9, 16}, {9, 0, 0}})
    ])
  end

  test "dTStartIsDate" do
    %RRule{
      freq: :daily,
      count: 3,
      dtstart: to_date({1997, 9, 2})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {0, 0, 0}}),
      to_datetime({{1997, 9, 3}, {0, 0, 0}}),
      to_datetime({{1997, 9, 4}, {0, 0, 0}})
    ])
  end

  test "dTStartWithMicroseconds" do
    %RRule{
      freq: :daily,
      count: 3,
      dtstart: parse("19970902090000.5", "{ASN1:GeneralizedTime}") |> to_datetime
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 3}, {9, 0, 0}}),
      to_datetime({{1997, 9, 4}, {9, 0, 0}})
    ])
  end

  test "maxYear" do
    %RRule{
      freq: :yearly,
      count: 3,
      bymonth: 2,
      bymonthday: 31,
      dtstart: to_datetime({{9997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([])
  end

  test "subsecondStartYearly" do
    %RRule{
      freq: :yearly,
      count: 1,
      dtstart: from_unix(1420063200001, :milliseconds)
    }
    |> RRule.occurrences
    |> assert_produces([
      from_unix(1420063200001, :milliseconds)
    ])
  end

  test "subsecondStartMonthlyByMonthDay" do
    %RRule{
      freq: :monthly,
      count: 1,
      bysetpos: [-1, 1],
      dtstart: from_unix(1356991200001, :milliseconds)
    }
    |> RRule.occurrences
    |> assert_produces([
      from_unix(1356991200001, :milliseconds)
    ])
  end

end