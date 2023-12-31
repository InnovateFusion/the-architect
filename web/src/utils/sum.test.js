const sum = require("./sum");

// Generated by CodiumAI

describe('sum', () => {

    // Returns the sum of two positive integers
    it('should return the sum of two positive integers', () => {
      expect(sum(2, 3)).toBe(5);
    });

    // Returns the sum of two negative integers
    it('should return the sum of two negative integers', () => {
      expect(sum(-2, -3)).toBe(-5);
    });

    // Returns the sum of a positive and a negative integer
    it('should return the sum of a positive and a negative integer', () => {
      expect(sum(2, -3)).toBe(-1);
    });

    // Returns NaN when one or both arguments are NaN
    it('should return NaN when one or both arguments are NaN', () => {
      expect(sum(NaN, 3)).toBe(NaN);
      expect(sum(2, NaN)).toBe(NaN);
      expect(sum(NaN, NaN)).toBe(NaN);
    });
});

