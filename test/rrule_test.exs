defmodule RRuleTest do
  use ExUnit.Case

  use Timex
  import Timex

  doctest RRule

  defp assert_produces(actual, expected) do
    assert actual == expected
  end

  @tag :todo
  test "before" do
    %RRule{
      freq: :daily,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrence_before(to_datetime({{1997, 9, 5}, {9, 0, 0}}))
    |> assert_produces(to_datetime({{1997, 9, 4}, {9, 0, 0}}))
  end

  @tag :todo
  test "beforeInc" do
    %RRule{
      freq: :daily,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrence_before(to_datetime({{1997, 9, 5}, {9, 0, 0}}), true)
    |> assert_produces(to_datetime({{1997, 9, 5}, {9, 0, 0}}))
  end

  @tag :todo
  test "after" do
    %RRule{
      freq: :daily,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrence_after(to_datetime({{1997, 9, 4}, {9, 0, 0}}))
    |> assert_produces(to_datetime({{1997, 9, 5}, {9, 0, 0}}))
  end

  @tag :todo
  test "afterInc" do
    %RRule{
      freq: :daily,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrence_after(to_datetime({{1997, 9, 4}, {9, 0, 0}}), true)
    |> assert_produces(to_datetime({{1997, 9, 4}, {9, 0, 0}}))
  end

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
  test "yearlyByWeekNoAndWeekDay" do
    # That"s a nice one. The first days of week number one
    # may be in the last year.
    %RRule{
      freq: :yearly,
      count: 3,
      byweekno: 1,
      byweekday: :monday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 29}, {9, 0, 0}}),
      to_datetime({{1999, 1, 4}, {9, 0, 0}}),
      to_datetime({{2000, 1, 3}, {9, 0, 0}})
    ])
  end

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
  test "yearlyByWeekNoAndWeekDay53" do
    %RRule{
      freq: :yearly,
      count: 3,
      byweekno: 53,
      byweekday: :monday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 12, 28}, {9, 0, 0}}),
      to_datetime({{2004, 12, 27}, {9, 0, 0}}),
      to_datetime({{2009, 12, 28}, {9, 0, 0}})
    ])
  end

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
  test "monthlyByWeekNoAndWeekDay" do
    # That"s a nice one. The first days of week number one
    # may be in the last year.
    %RRule{
      freq: :monthly,
      count: 3,
      byweekno: 1,
      byweekday: :monday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 29}, {9, 0, 0}}),
      to_datetime({{1999, 1, 4}, {9, 0, 0}}),
      to_datetime({{2000, 1, 3}, {9, 0, 0}})
    ])
  end

  @tag :todo
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

  @tag :todo
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

  @tag :todo
  test "monthlyByWeekNoAndWeekDay53" do
    %RRule{
      freq: :monthly,
      count: 3,
      byweekno: 53,
      byweekday: :monday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 12, 28}, {9, 0, 0}}),
      to_datetime({{2004, 12, 27}, {9, 0, 0}}),
      to_datetime({{2009, 12, 28}, {9, 0, 0}})
    ])
  end

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
  test "weeklyByWeekNoAndWeekDay" do
    # That"s a nice one. The first days of week number one
    # may be in the last year.
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      byweekno: 1,
      byweekday: :monday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 29}, {9, 0, 0}}),
      to_datetime({{1999, 1, 4}, {9, 0, 0}}),
      to_datetime({{2000, 1, 3}, {9, 0, 0}})
    ])
  end

  @tag :todo
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

  @tag :todo
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

  @tag :todo
  test "weeklyByWeekNoAndWeekDay53" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      byweekno: 53,
      byweekday: :monday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 12, 28}, {9, 0, 0}}),
      to_datetime({{2004, 12, 27}, {9, 0, 0}}),
      to_datetime({{2009, 12, 28}, {9, 0, 0}})
    ])
  end

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
  test "dailyByWeekNoAndWeekDay" do
    # That"s a nice one. The first days of week number one
    # may be in the last year.
    %RRule{
      freq: :daily,
      count: 3,
      byweekno: 1,
      byweekday: :monday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 29}, {9, 0, 0}}),
      to_datetime({{1999, 1, 4}, {9, 0, 0}}),
      to_datetime({{2000, 1, 3}, {9, 0, 0}})
    ])
  end

  @tag :todo
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

  @tag :todo
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

  @tag :todo
  test "dailyByWeekNoAndWeekDay53" do
    %RRule{
      freq: :daily,
      count: 3,
      byweekno: 53,
      byweekday: :monday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1998, 12, 28}, {9, 0, 0}}),
      to_datetime({{2004, 12, 27}, {9, 0, 0}}),
      to_datetime({{2009, 12, 28}, {9, 0, 0}})
    ])
  end

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
  test "hourlyByWeekNoAndWeekDay" do
    %RRule{
      freq: :hourly,
      count: 3,
      byweekno: 1,
      byweekday: :monday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 29}, {0, 0, 0}}),
      to_datetime({{1997, 12, 29}, {1, 0, 0}}),
      to_datetime({{1997, 12, 29}, {2, 0, 0}})
    ])
  end

  @tag :todo
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

  @tag :todo
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

  @tag :todo
  test "hourlyByWeekNoAndWeekDay53" do
    %RRule{
      freq: :hourly,
      count: 3,
      byweekno: 53,
      byweekday: :monday,
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
  test "minutelyByWeekNoAndWeekDay" do
    %RRule{
      freq: :minutely,
      count: 3,
      byweekno: 1,
      byweekday: :monday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 29}, {0, 0, 0}}),
      to_datetime({{1997, 12, 29}, {0, 1, 0}}),
      to_datetime({{1997, 12, 29}, {0, 2, 0}})
    ])
  end

  @tag :todo
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

  @tag :todo
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

  @tag :todo
  test "minutelyByWeekNoAndWeekDay53" do
    %RRule{
      freq: :minutely,
      count: 3,
      byweekno: 53,
      byweekday: :monday,
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
  test "secondlyByWeekNoAndWeekDay" do
    %RRule{
      freq: :secondly,
      count: 3,
      byweekno: 1,
      byweekday: :monday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 12, 29}, {0, 0, 0}}),
      to_datetime({{1997, 12, 29}, {0, 0, 1}}),
      to_datetime({{1997, 12, 29}, {0, 0, 2}})
    ])
  end

  @tag :todo
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

  @tag :todo
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

  @tag :todo
  test "secondlyByWeekNoAndWeekDay53" do
    %RRule{
      freq: :secondly,
      count: 3,
      byweekno: 53,
      byweekday: :monday,
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
  test "wkStIntervalMO" do
    %RRule{
      freq: RRule.WEEKLY,
      count: 3,
      interval: 2,
      byweekday: [:tuesday, :sunday],
      wkst: :monday,
      dtstart: to_datetime({{1997, 9, 2}, {9, 0, 0}})
    }
    |> RRule.occurrences
    |> assert_produces([
      to_datetime({{1997, 9, 2}, {9, 0, 0}}),
      to_datetime({{1997, 9, 7}, {9, 0, 0}}),
      to_datetime({{1997, 9, 16}, {9, 0, 0}})
    ])
  end

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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

  @tag :todo
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