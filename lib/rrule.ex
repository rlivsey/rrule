defmodule RRule do
  defstruct [:freq, :dtstart, :count, :interval, :bymonth, :bymonthday, :byweekday, :byyearday, :byweekno, :byeaster, :byhour, :byminute, :bysecond, :bysetpos, :until, :wkst]

  def occurrence_before(_rrule, _time) do
  end

  def occurrence_before(_rrule, _time, true) do
  end

  def occurrence_after(_rrule, _time) do
  end

  def occurrence_after(_rrule, _time, true) do
  end

  def occurrences_between(_rrule, _start, _end) do
  end

  def occurrences_between(_rrule, _start, _end, true) do
  end

  def occurrences(_rrule) do
  end

end
