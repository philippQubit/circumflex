package ru.circumflex.orm

/**
 * Defines a contract for parent-child (one-to-many) associations.
 * Usually they are modelled as tables with foreign keys.
 */
trait Association[C <: Record, P <: Record] {
  /**
   * Returns parent relation.
   */
  def parentRelation: Relation[P]

  /**
   * Returns child relation.
   */
  def childRelation: Relation[C]

  /**
   * Returns a list of local columns.
   */
  def localColumn: Column[_, C]

  /**
   * Returns a column of the referenced table (parent) that matches local column.
   */
  def referenceColumn: Column[_, P]

}
