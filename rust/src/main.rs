// `mod lexer` tells Rust to look for src/lexer.rs or src/lexer/mod.rs
mod lexer;

fn main() {
    println!("{}", lexer::hello())
}
