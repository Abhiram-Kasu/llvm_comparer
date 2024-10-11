package llvm_comparer

import "core:fmt"
import "core:os"
import "core:strings"

swiftLlvmEmmitCommand :: proc(swiftFile: string, outputDir: string) -> string {
	return strings.concatenate({"swiftc -emit-ir ", swiftFile, " -o ", outputDir, "/output.ll"})
}


main :: proc() {
	fmt.println("Setting up directories...")
	projectDirs := [?]SetUpDirectoryProc{setUpSwiftDirectories, setUpRustDirectories}

	for projectDir in projectDirs {

		if name, err := projectDir(); err != nil {
			fmt.println("Error creating directory: ", err)
		} else {
			fmt.println("Created directory: ", name)
		}

	}


}

SetUpDirectoryProc :: proc() -> (string, os.Error)

setUpSwiftDirectories :: proc() -> (string, os.Error) {
	return "swift", os.make_directory("./swift_projects/")
}

setUpRustDirectories :: proc() -> (string, os.Error) {
	return "rust", os.make_directory("./rust_projects/")
}
