module test;

// Copyright 2022 Kai Daniel Gonzalez. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import dvfs;
import std.stdio;
import std.conv : to;

void main() {
    string file_name = "hello.txt";
    string file_text = "Sample file";

    VFileSys sys = new VFileSys();

    VDirectory root = sys.rootNode();

    root.createDirectory(new VDirectory("test_directory"));

    VDirectory dirRef = root.getDirectory("test_directory");

    VFile file = new VFile(file_name);
    file.contents = file_text;
    file.setPermissions(VPerm.read_write);

    VFile file2 = new VFile("F2.txt");
    file2.contents = file_text;
    file2.setPermissions(VPerm.read);

    dirRef.addFile(file);
    dirRef.addFile(file2);

    VFile f = dirRef.getFile(file_name);

    foreach (VFile fi; dirRef.getFiles()) {
        writeln(fi.getFileName() ~ 
            "\ncontent length: " ~ f.readFileText().length.to!string ~ "\ncontent: " ~ f.readFileText());
        
    }
}