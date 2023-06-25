# GdUnit generated TestSuite
class_name StackTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

class TestItem extends Item:
	func _init() -> void:
		super()
		id = Guid.v4()
		name = "Test Item"
		is_stackable = true
		max_stack_size = 10



# TestSuite generated from
const __source = 'res://addons/enhanced_inventory/scripts/core/stack.gd'


func test_entire_fill_to() -> void:
	var item: Item = TestItem.new()

	var stack: Stack = Stack.new(item, 0)
	var remaining: int = stack.fill_to(10)
	assert_int(stack.quantity).is_equal(10)
	assert_int(remaining).is_equal(0)

func test_clean_fill_to() -> void:
	var item: Item = TestItem.new()

	var stack: Stack = Stack.new(item, 0)
	var remaining: int = stack.fill_to(5)
	assert_int(stack.quantity).is_equal(5)
	assert_int(remaining).is_equal(0)

func test_dirty_fill_to() -> void:
	var item: Item = TestItem.new()

	var stack: Stack = Stack.new(item, 0)
	var remaining: int = stack.fill_to(15)
	assert_int(stack.quantity).is_equal(10)
	assert_int(remaining).is_equal(5)

func test_negative_fill_to() -> void:
	var item: Item = TestItem.new()

	var stack: Stack = Stack.new(item, 0)
	var remaining: int = stack.fill_to(-10)
	assert_int(stack.quantity).is_equal(0)
	assert_int(remaining).is_equal(0)


func test_even_split() -> void:
	var item: Item = TestItem.new()
	var stack: Stack = Stack.new(item, 10)

	var remaining: int = stack.split()
	
	assert_int(stack.quantity).is_equal(5)
	assert_int(remaining).is_equal(5)

func test_odd_split() -> void:
	var item: Item = TestItem.new()
	var stack: Stack = Stack.new(item, 11)

	var remaining: int = stack.split()
	
	assert_int(stack.quantity).is_equal(6)
	assert_int(remaining).is_equal(5)

func test_negative_split() -> void:
	var item: Item = TestItem.new()
	var stack: Stack = Stack.new(item, -1)

	var remaining: int = stack.split()
	
	assert_int(stack.quantity).is_equal(0)
	assert_int(remaining).is_equal(0)
