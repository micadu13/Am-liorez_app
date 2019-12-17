//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {
    var calc : Calculation!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        calc = Calculation(text: "")
        
        
    }

    //Test Divison By 0
    
    func testGivenThree_WhenAdditionSeven_ThenEqualTen() {
        calc.addNumber(number: "3")
        XCTAssertNoThrow(try calc.addition())
        
        calc.addNumber(number: "7")
        XCTAssertNoThrow(try calc.calculate())
        XCTAssert(calc.text == "3 + 7 = 10.0")
        
        
    }
    func testGivenTwo_WhenMultiplicationFive_ThenEqualTen(){
        calc.addNumber(number: "2")
        XCTAssertNoThrow( try calc.multiplication())
        calc.addNumber(number: "5")
        XCTAssertNoThrow(try calc.calculate())
        XCTAssert(calc.text == "2 * 5 = 10.0")
    }
    
    func testGivenEight_WhenSubstractFour_ThenEqualFour(){
        calc.addNumber(number: "8")
        XCTAssertNoThrow( try calc.soustraction())
        calc.addNumber(number: "4")
        XCTAssertNoThrow(try calc.calculate())
        XCTAssert(calc.text == "8 - 4 = 4.0")
        
    }
    func testGivenTen_WhenDivisionTwo_ThenEqualFive(){
        calc.addNumber(number: "10")
        XCTAssertNoThrow( try calc.division())
        calc.addNumber(number: "2")
        XCTAssertNoThrow(try calc.calculate())
        XCTAssert(calc.text == "10 / 2 = 5.0")
        
    }
    
    func testGivenStartPriorityOfOperations_WhenMakingTheOperations_ThenResultOfOperations(){
        //(10*3+10/2-5) => 30+15-5=>45-5=>30
        calc.addNumber(number: "10")
        XCTAssertNoThrow(try calc.multiplication())
        calc.addNumber(number: "3")
        XCTAssertNoThrow(try calc.addition())
        calc.addNumber(number: "10")
        XCTAssertNoThrow(try calc.division())
        calc.addNumber(number: "2")
        XCTAssertNoThrow(try calc.soustraction())
        calc.addNumber(number: "5")
        XCTAssertNoThrow(try calc.calculate())
        XCTAssert(calc.text == "10 * 3 + 10 / 2 - 5 = 30.0")
        
    }
    

    
    
    func testGivenThree_WhenAdditionTwice_ThenThrowCannotAddOperator() {
        calc.addNumber(number: "3")
        XCTAssertNoThrow(try calc.addition())
        
        do {
            try calc.addition()
        } catch (Calculation.Error.cannotAddOperator) {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
    
    func testGivenThree_WhenDivisionTwo_ThenThrowErrorWithZero(){
        calc.addNumber(number: "3")
        XCTAssertNoThrow(try calc.division())
        calc.addNumber(number: "0")
        do {
            try calc.calculate()
        } catch (Calculation.Error.cannotUseZero) {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
    
    func testGivenTwoElements_WhenAddition_ThenThrowDoesNotHaveEnoughElement(){
        calc.addNumber(number: "3")
        XCTAssertNoThrow(try calc.addition())
        do {
            try calc.calculate()
        } catch (Calculation.Error.expressionDoesNotHaveEnoughtElement) {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
    
    func testGivenTwoElements_WhenAddition_ThenThrowIsNotCorrect(){
        calc.addNumber(number: "3")
        XCTAssertNoThrow(try calc.addition())
        calc.addNumber(number: "2")
         XCTAssertNoThrow(try calc.addition())
        do {
            try calc.calculate()
        } catch (Calculation.Error.expressionIsNotCorrect) {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
    
    func testGivenSomeElements_WhenClear_ThenTexisEmpty(){
        calc.addNumber(number: "3")
        calc.clear()
        XCTAssert(calc.text == "")
    }
  
    func testGivenCalculIsDone_WhenStartANewCalcul_ThenStartANewCalcul(){
        calc.addNumber(number: "3")
        XCTAssertNoThrow(try calc.addition())
        calc.addNumber(number: "3")
        XCTAssertNoThrow(try calc.calculate())
        calc.addNumber(number: "4")
        XCTAssert(calc.text == "4")
        
    }
    
    
    func testGivenCalculIsDone_WhenStartANewCalcul_ThenStartANewCalculAndThrowAnError(){
        calc.addNumber(number: "3")
        XCTAssertNoThrow(try calc.addition())
        calc.addNumber(number: "3")
        XCTAssertNoThrow(try calc.calculate())
        do {
            try calc.addition()
        }
        catch Calculation.Error.cannotAddOperator{
            XCTAssert(true)
        }
        
        catch {
            XCTAssert(false)
        }
    }
    func testGivenisEmpty_WhenStartingWithOneOperator_ThenCannotStartACalcul(){
        calc.clear()
        do {
            try calc.addition()
        }
        catch Calculation.Error.cannotAddOperator{
            XCTAssert(true)
        }
        catch {
            XCTAssert(false)
        }
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
