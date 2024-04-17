import Foundation

//
//  StringStuff.swift
//
//  Created by Ioana Marinescu
//  Created on 2024/04/17
//  Version 1.0
//  Copyright (c) 2024 Ioana Marinescu. All rights reserved.
//
// This program finds the max run and Strung blow up of the input to and from a file.

// File paths
let inputPath = "Assign-02-Swift-StringStuff/output.txt"
let outputPath = "Assign-02-Swift-StringStuff/output.txt"

// Tries reading 
guard let inputString = try? String(contentsOfFile: inputPath, encoding: .utf8) else {
    fatalError("File, \(inputPath), could not be found. Please fix the file path.")
}

// Seperates file content by new lines \n
let lines = inputString.components(separatedBy: .newlines)

// File writing
let fileWriter = FileWriter(outputFilePath: outputFilePath)

// There are an incorrect amount of lines in a file
if lines.count % 1 {
    print("There is a missing line in the file. Please make sure your input file is in order.")

    // There are a correct amount of lines in the file
} else {
    // Loop through pairs of lines in array
    for i in 1...(lines.count / 2) {
        // getting lines
        let line1 = lines[i]
        let line2 = lines[i + 1]

        // Process line1 and line2 using utility functions
        let stringBlowUpResult = stringBlowUp(Array(line1))
        let maxRunResult = maxRun(Array(line2))

        // Write results to the output file
        do {
            try fileWriter.write("The string blow up is \(stringBlowUpResult)\n")
            try fileWriter.write("The max run is \(maxRunResult)\n")
        } catch {
            // Error occured while trying to write to file
            print("Error: Failed to write to output file '\(outputFilePath)': \(error)")
            return
        }
    }

    print("Processing completed successfully.")
}
// Close file writer
fileWriter.close()

// Calculates the maximum consecutive run of identical characters in the given array of characters.
static func maxRun(_ input: [Character]) -> Int {
    // Variables
    var currentRun = 0
    var highestRun = 0

    // Loops through the array to check each letter
    for i in 0..<input.count {
        // If last character or character is the same as the next
        if i == input.count - 1 || input[i] != input[i + 1] {
            // If the current run is higher than the highest run
            highestRun = max(highestRun, currentRun)
            currentRun = 0

            // Character is not the last, nor the same as the one after it
        } else {
            curren tRun += 1
        }
    }

    // Return max run
    return highestRun
}

/// Performs the string blow-up operation on the given array of characters.
static func stringBlowUp(_ input: [Character]) -> String {
    // Variables
    var output = ""
    var i = 0

    // loop through array
    while i < input.count {
        // Check if the current element is a digit and if there's a character next to it
        if let digit = Int(input[i]), i + 1 < input.count {
            // Add the next character 'digit' times to the output string
            output += String(repeating: String(input[i + 1]), count: max(0, digit))
            i++
        } else {
            // Add to output
            output.append(input[i])
            i += 1
        }
    }

    // Return the blown up string
    return output
}


// A utility class for writing to an output file.
// This function was entirely sourced from https://chat.openai.com
func FileWriter {
    private let fileURL: URL
    private let fileHandle: FileHandle

    init(outputFilePath: String) {
        self.fileURL = URL(fileURLWithPath: outputFilePath)
        if !FileManager.default.fileExists(atPath: outputFilePath) {
            FileManager.default.createFile(atPath: outputFilePath, contents: nil, attributes: nil)
        }
        self.fileHandle = try! FileHandle(forWritingTo: fileURL)
    }

    func write(_ string: String) throws {
        if let data = string.data(using: .utf8) {
            fileHandle.write(data)
        }
    }

    func close() {
        fileHandle.closeFile()
    }
}
