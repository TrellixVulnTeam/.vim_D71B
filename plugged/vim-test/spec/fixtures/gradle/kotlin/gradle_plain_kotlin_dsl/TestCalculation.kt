package org.vimtest.calc

import org.junit.Assert.assertEquals
import org.junit.Test

class TestCalculation {
    @Test
    fun testAdd() {
        val sum = Calculation.add(3, 5)
        assertEquals(sum, 8)
    }

    @Test
    fun testFailedAdd() {
        val sum = Calculation.add(3, 5)
        assertEquals(sum, 9)
    }

    @Test
    fun testSub() {
        val sum = Calculation.sub(5, 3)
        assertEquals(sum, 2)
    }

    @Test
    fun testFailedSub() {
        val sum = Calculation.sub(5, 3)
        assertEquals(sum, 3)
    }
}
