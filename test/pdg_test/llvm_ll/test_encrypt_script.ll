; ModuleID = 'test_encrypt_script.c'
source_filename = "test_encrypt_script.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

@.str = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c", welcome!\0A\00", align 1
@key = common global i8* null, align 8
@i = common global i32 0, align 4
@ciphertext = common global i8* null, align 8
@.str.2 = private unnamed_addr constant [17 x i8] c"Enter username: \00", align 1
@.str.3 = private unnamed_addr constant [5 x i8] c"%19s\00", align 1
@.str.4 = private unnamed_addr constant [18 x i8] c"Enter plaintext: \00", align 1
@.str.5 = private unnamed_addr constant [7 x i8] c"%1023s\00", align 1
@.str.6 = private unnamed_addr constant [14 x i8] c"Cipher text: \00", align 1
@.str.7 = private unnamed_addr constant [4 x i8] c"%x \00", align 1
@.str.8 = private unnamed_addr constant [10 x i8] c"sensitive\00", section "llvm.metadata"
@.str.9 = private unnamed_addr constant [22 x i8] c"test_encrypt_script.c\00", section "llvm.metadata"
@llvm.global.annotations = appending global [1 x { i8*, i8*, i8*, i32 }] [{ i8*, i8*, i8*, i32 } { i8* bitcast (i8** @key to i8*), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.8, i32 0, i32 0), i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.9, i32 0, i32 0), i32 5 }], section "llvm.metadata"

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @greeter(i8*) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i8* %3)
  %5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i64 0, i64 0))
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @initkey(i32) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = sext i32 %3 to i64
  %5 = call i8* @malloc(i64 %4) #3
  store i8* %5, i8** @key, align 8
  store i32 0, i32* @i, align 4
  br label %6

6:                                                ; preds = %15, %1
  %7 = load i32, i32* @i, align 4
  %8 = load i32, i32* %2, align 4
  %9 = icmp ult i32 %7, %8
  br i1 %9, label %10, label %18

10:                                               ; preds = %6
  %11 = load i8*, i8** @key, align 8
  %12 = load i32, i32* @i, align 4
  %13 = zext i32 %12 to i64
  %14 = getelementptr inbounds i8, i8* %11, i64 %13
  store i8 1, i8* %14, align 1
  br label %15

15:                                               ; preds = %10
  %16 = load i32, i32* @i, align 4
  %17 = add i32 %16, 1
  store i32 %17, i32* @i, align 4
  br label %6

18:                                               ; preds = %6
  ret void
}

; Function Attrs: allocsize(0)
declare i8* @malloc(i64) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @encrypt(i8*, i32) #0 {
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %4, align 4
  %6 = sext i32 %5 to i64
  %7 = call i8* @malloc(i64 %6) #3
  store i8* %7, i8** @ciphertext, align 8
  store i32 0, i32* @i, align 4
  br label %8

8:                                                ; preds = %31, %2
  %9 = load i32, i32* @i, align 4
  %10 = load i32, i32* %4, align 4
  %11 = icmp ult i32 %9, %10
  br i1 %11, label %12, label %34

12:                                               ; preds = %8
  %13 = load i8*, i8** %3, align 8
  %14 = load i32, i32* @i, align 4
  %15 = zext i32 %14 to i64
  %16 = getelementptr inbounds i8, i8* %13, i64 %15
  %17 = load i8, i8* %16, align 1
  %18 = sext i8 %17 to i32
  %19 = load i8*, i8** @key, align 8
  %20 = load i32, i32* @i, align 4
  %21 = zext i32 %20 to i64
  %22 = getelementptr inbounds i8, i8* %19, i64 %21
  %23 = load i8, i8* %22, align 1
  %24 = sext i8 %23 to i32
  %25 = xor i32 %18, %24
  %26 = trunc i32 %25 to i8
  %27 = load i8*, i8** @ciphertext, align 8
  %28 = load i32, i32* @i, align 4
  %29 = zext i32 %28 to i64
  %30 = getelementptr inbounds i8, i8* %27, i64 %29
  store i8 %26, i8* %30, align 1
  br label %31

31:                                               ; preds = %12
  %32 = load i32, i32* @i, align 4
  %33 = add i32 %32, 1
  store i32 %33, i32* @i, align 4
  br label %8

34:                                               ; preds = %8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [20 x i8], align 16
  %3 = alloca [1024 x i8], align 16
  store i32 0, i32* %1, align 4
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.2, i64 0, i64 0))
  %5 = getelementptr inbounds [20 x i8], [20 x i8]* %2, i64 0, i64 0
  %6 = call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.3, i64 0, i64 0), i8* %5)
  %7 = getelementptr inbounds [20 x i8], [20 x i8]* %2, i64 0, i64 0
  call void @greeter(i8* %7)
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.4, i64 0, i64 0))
  %9 = getelementptr inbounds [1024 x i8], [1024 x i8]* %3, i64 0, i64 0
  %10 = call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.5, i64 0, i64 0), i8* %9)
  %11 = getelementptr inbounds [1024 x i8], [1024 x i8]* %3, i64 0, i64 0
  %12 = call i64 @strlen(i8* %11)
  %13 = trunc i64 %12 to i32
  call void @initkey(i32 %13)
  %14 = getelementptr inbounds [1024 x i8], [1024 x i8]* %3, i64 0, i64 0
  %15 = getelementptr inbounds [1024 x i8], [1024 x i8]* %3, i64 0, i64 0
  %16 = call i64 @strlen(i8* %15)
  %17 = trunc i64 %16 to i32
  call void @encrypt(i8* %14, i32 %17)
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.6, i64 0, i64 0))
  store i32 0, i32* @i, align 4
  br label %19

19:                                               ; preds = %33, %0
  %20 = load i32, i32* @i, align 4
  %21 = zext i32 %20 to i64
  %22 = getelementptr inbounds [1024 x i8], [1024 x i8]* %3, i64 0, i64 0
  %23 = call i64 @strlen(i8* %22)
  %24 = icmp ult i64 %21, %23
  br i1 %24, label %25, label %36

25:                                               ; preds = %19
  %26 = load i8*, i8** @ciphertext, align 8
  %27 = load i32, i32* @i, align 4
  %28 = zext i32 %27 to i64
  %29 = getelementptr inbounds i8, i8* %26, i64 %28
  %30 = load i8, i8* %29, align 1
  %31 = sext i8 %30 to i32
  %32 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.7, i64 0, i64 0), i32 %31)
  br label %33

33:                                               ; preds = %25
  %34 = load i32, i32* @i, align 4
  %35 = add i32 %34, 1
  store i32 %35, i32* @i, align 4
  br label %19

36:                                               ; preds = %19
  ret i32 0
}

declare i32 @scanf(i8*, ...) #1

declare i64 @strlen(i8*) #1

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { allocsize(0) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { allocsize(0) }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 9.0.0 (tags/RELEASE_900/final)"}
