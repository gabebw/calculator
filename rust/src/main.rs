#![feature(collections)]

// `mod lexer` tells Rust to look for src/lexer.rs or src/lexer/mod.rs
mod lexer;
mod parser;

fn main() {
    let code = "100 + 2 / 3";
    let lexed = lexer::lex(code);

    for item in lexed.iter() {
        println!("lexed item: {}", item);
    }

    let parsed = parser::parse(lexed);
    for item in parsed.iter() {
        println!("parsed item: {}", item);
    }
}
