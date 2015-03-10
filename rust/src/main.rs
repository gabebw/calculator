#![feature(collections)]

// `mod lexer` tells Rust to look for src/lexer.rs or src/lexer/mod.rs
mod lexer;

fn main() {
    let code = "100 + 2 / 3";
    let lexed = lexer::lex(code);

    for item in lexed.iter() {
        println!("item: {}", item);
    }
}
