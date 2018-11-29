; ModuleID = 'example.k4.c'
source_filename = "example.k4.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.node = type { %struct.device*, %struct.node* }
%struct.device = type { void (%struct.device*)*, i8*, i32 }

@device_list_head = common global %struct.node* null, align 8, !dbg !0
@.str = private unnamed_addr constant [11 x i8] c"opened %s\0A\00", align 1
@.str.1 = private unnamed_addr constant [25 x i8] c"Add device to the list:\0A\00", align 1
@dev1 = internal global %struct.device { void (%struct.device*)* @dev1_open, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0), i32 0 }, align 8, !dbg !25
@dev2 = internal global %struct.device { void (%struct.device*)* @dev2_open, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.3, i32 0, i32 0), i32 0 }, align 8, !dbg !27
@.str.2 = private unnamed_addr constant [9 x i8] c"device_1\00", align 1
@.str.3 = private unnamed_addr constant [9 x i8] c"device_2\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @init(%struct.node* %head) #0 !dbg !33 {
entry:
  %head.addr = alloca %struct.node*, align 8
  store %struct.node* %head, %struct.node** %head.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.node** %head.addr, metadata !36, metadata !DIExpression()), !dbg !37
  store %struct.node* null, %struct.node** %head.addr, align 8, !dbg !38
  ret void, !dbg !39
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define void @register_device(%struct.device* %dev) #0 !dbg !40 {
entry:
  %dev.addr = alloca %struct.device*, align 8
  %new_node = alloca %struct.node*, align 8
  store %struct.device* %dev, %struct.device** %dev.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.device** %dev.addr, metadata !41, metadata !DIExpression()), !dbg !42
  call void @llvm.dbg.declare(metadata %struct.node** %new_node, metadata !43, metadata !DIExpression()), !dbg !44
  %call = call noalias i8* @malloc(i64 16) #5, !dbg !45
  %0 = bitcast i8* %call to %struct.node*, !dbg !46
  store %struct.node* %0, %struct.node** %new_node, align 8, !dbg !44
  %1 = load %struct.device*, %struct.device** %dev.addr, align 8, !dbg !47
  %2 = load %struct.node*, %struct.node** %new_node, align 8, !dbg !48
  %dev1 = getelementptr inbounds %struct.node, %struct.node* %2, i32 0, i32 0, !dbg !49
  store %struct.device* %1, %struct.device** %dev1, align 8, !dbg !50
  %3 = load %struct.node*, %struct.node** @device_list_head, align 8, !dbg !51
  %4 = load %struct.node*, %struct.node** %new_node, align 8, !dbg !52
  %next = getelementptr inbounds %struct.node, %struct.node* %4, i32 0, i32 1, !dbg !53
  store %struct.node* %3, %struct.node** %next, align 8, !dbg !54
  %5 = load %struct.node*, %struct.node** %new_node, align 8, !dbg !55
  store %struct.node* %5, %struct.node** @device_list_head, align 8, !dbg !56
  ret void, !dbg !57
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @open(%struct.device* %dev) #0 !dbg !58 {
entry:
  %dev.addr = alloca %struct.device*, align 8
  store %struct.device* %dev, %struct.device** %dev.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.device** %dev.addr, metadata !61, metadata !DIExpression()), !dbg !62
  %0 = load %struct.device*, %struct.device** %dev.addr, align 8, !dbg !63
  %open = getelementptr inbounds %struct.device, %struct.device* %0, i32 0, i32 0, !dbg !64
  %1 = load void (%struct.device*)*, void (%struct.device*)** %open, align 8, !dbg !64
  %2 = load %struct.device*, %struct.device** %dev.addr, align 8, !dbg !65
  call void %1(%struct.device* %2), !dbg !63
  %3 = load %struct.device*, %struct.device** %dev.addr, align 8, !dbg !66
  %name = getelementptr inbounds %struct.device, %struct.device* %3, i32 0, i32 1, !dbg !67
  %4 = load i8*, i8** %name, align 8, !dbg !67
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0), i8* %4), !dbg !68
  ret i32 1, !dbg !69
}

declare i32 @printf(i8*, ...) #3

; Function Attrs: noinline nounwind optnone uwtable
define void @device_reset(i32* %dev_init) #0 !dbg !70 {
entry:
  %dev_init.addr = alloca i32*, align 8
  store i32* %dev_init, i32** %dev_init.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %dev_init.addr, metadata !74, metadata !DIExpression()), !dbg !75
  %0 = load i32*, i32** %dev_init.addr, align 8, !dbg !76
  store i32 0, i32* %0, align 4, !dbg !77
  ret void, !dbg !78
}

; Function Attrs: noinline nounwind optnone uwtable
define %struct.device* @lookup_device(i8* %search_name) #0 !dbg !79 {
entry:
  %retval = alloca %struct.device*, align 8
  %search_name.addr = alloca i8*, align 8
  %current = alloca %struct.node*, align 8
  store i8* %search_name, i8** %search_name.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %search_name.addr, metadata !82, metadata !DIExpression()), !dbg !83
  call void @llvm.dbg.declare(metadata %struct.node** %current, metadata !84, metadata !DIExpression()), !dbg !85
  %0 = load %struct.node*, %struct.node** @device_list_head, align 8, !dbg !86
  store %struct.node* %0, %struct.node** %current, align 8, !dbg !85
  br label %while.cond, !dbg !87

while.cond:                                       ; preds = %if.end, %entry
  %1 = load %struct.node*, %struct.node** %current, align 8, !dbg !88
  %cmp = icmp ne %struct.node* %1, null, !dbg !89
  br i1 %cmp, label %while.body, label %while.end, !dbg !87

while.body:                                       ; preds = %while.cond
  %2 = load %struct.node*, %struct.node** %current, align 8, !dbg !90
  %dev = getelementptr inbounds %struct.node, %struct.node* %2, i32 0, i32 0, !dbg !93
  %3 = load %struct.device*, %struct.device** %dev, align 8, !dbg !93
  %name = getelementptr inbounds %struct.device, %struct.device* %3, i32 0, i32 1, !dbg !94
  %4 = load i8*, i8** %name, align 8, !dbg !94
  %5 = load i8*, i8** %search_name.addr, align 8, !dbg !95
  %call = call i32 @strcmp(i8* %4, i8* %5) #6, !dbg !96
  %cmp1 = icmp eq i32 %call, 0, !dbg !97
  br i1 %cmp1, label %if.then, label %if.else, !dbg !98

if.then:                                          ; preds = %while.body
  %6 = load %struct.node*, %struct.node** %current, align 8, !dbg !99
  %dev2 = getelementptr inbounds %struct.node, %struct.node* %6, i32 0, i32 0, !dbg !100
  %7 = load %struct.device*, %struct.device** %dev2, align 8, !dbg !100
  store %struct.device* %7, %struct.device** %retval, align 8, !dbg !101
  br label %return, !dbg !101

if.else:                                          ; preds = %while.body
  %8 = load %struct.node*, %struct.node** %current, align 8, !dbg !102
  %next = getelementptr inbounds %struct.node, %struct.node* %8, i32 0, i32 1, !dbg !103
  %9 = load %struct.node*, %struct.node** %next, align 8, !dbg !103
  store %struct.node* %9, %struct.node** %current, align 8, !dbg !104
  br label %if.end

if.end:                                           ; preds = %if.else
  br label %while.cond, !dbg !87, !llvm.loop !105

while.end:                                        ; preds = %while.cond
  store %struct.device* null, %struct.device** %retval, align 8, !dbg !107
  br label %return, !dbg !107

return:                                           ; preds = %while.end, %if.then
  %10 = load %struct.device*, %struct.device** %retval, align 8, !dbg !108
  ret %struct.device* %10, !dbg !108
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #4

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !109 {
entry:
  %retval = alloca i32, align 4
  %dev = alloca %struct.device*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.device** %dev, metadata !112, metadata !DIExpression()), !dbg !113
  %0 = load %struct.node*, %struct.node** @device_list_head, align 8, !dbg !114
  call void @init(%struct.node* %0), !dbg !115
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.1, i32 0, i32 0)), !dbg !116
  call void @register_device(%struct.device* @dev1), !dbg !117
  call void @register_device(%struct.device* @dev2), !dbg !118
  %call1 = call %struct.device* @lookup_device(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0)), !dbg !119
  store %struct.device* %call1, %struct.device** %dev, align 8, !dbg !120
  %1 = load %struct.device*, %struct.device** %dev, align 8, !dbg !121
  %call2 = call i32 @open(%struct.device* %1), !dbg !122
  %call3 = call %struct.device* @lookup_device(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.3, i32 0, i32 0)), !dbg !123
  store %struct.device* %call3, %struct.device** %dev, align 8, !dbg !124
  %2 = load %struct.device*, %struct.device** %dev, align 8, !dbg !125
  %call4 = call i32 @open(%struct.device* %2), !dbg !126
  ret i32 0, !dbg !127
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @dev1_open(%struct.device* %dev) #0 !dbg !128 {
entry:
  %dev.addr = alloca %struct.device*, align 8
  store %struct.device* %dev, %struct.device** %dev.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.device** %dev.addr, metadata !129, metadata !DIExpression()), !dbg !130
  %0 = load %struct.device*, %struct.device** %dev.addr, align 8, !dbg !131
  %devop_init_registered = getelementptr inbounds %struct.device, %struct.device* %0, i32 0, i32 2, !dbg !132
  call void @device_reset(i32* %devop_init_registered), !dbg !133
  ret void, !dbg !134
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @dev2_open(%struct.device* %dev) #0 !dbg !135 {
entry:
  %dev.addr = alloca %struct.device*, align 8
  store %struct.device* %dev, %struct.device** %dev.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.device** %dev.addr, metadata !136, metadata !DIExpression()), !dbg !137
  %0 = load %struct.device*, %struct.device** %dev.addr, align 8, !dbg !138
  %devop_init_registered = getelementptr inbounds %struct.device, %struct.device* %0, i32 0, i32 2, !dbg !139
  store i32 1, i32* %devop_init_registered, align 8, !dbg !140
  ret void, !dbg !141
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { nounwind readonly }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!29, !30, !31}
!llvm.ident = !{!32}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "device_list_head", scope: !2, file: !3, line: 23, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 7.0.0 (trunk 323988) (llvm/trunk 323938)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !24)
!3 = !DIFile(filename: "example.k4.c", directory: "/home/yongzhe/llvm-versions/llvm-5.0/lib/Analysis/PDG/test/test_idl_gen")
!4 = !{}
!5 = !{!6, !23}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !3, line: 18, size: 128, elements: !8)
!8 = !{!9, !22}
!9 = !DIDerivedType(tag: DW_TAG_member, name: "dev", scope: !7, file: !3, line: 19, baseType: !10, size: 64)
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "device", file: !3, line: 12, size: 192, elements: !12)
!12 = !{!13, !17, !20}
!13 = !DIDerivedType(tag: DW_TAG_member, name: "open", scope: !11, file: !3, line: 13, baseType: !14, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DISubroutineType(types: !16)
!16 = !{null, !10}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !11, file: !3, line: 14, baseType: !18, size: 64, offset: 64)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "devop_init_registered", scope: !11, file: !3, line: 15, baseType: !21, size: 32, offset: 128)
!21 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !7, file: !3, line: 20, baseType: !6, size: 64, offset: 64)
!23 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!24 = !{!0, !25, !27}
!25 = !DIGlobalVariableExpression(var: !26, expr: !DIExpression())
!26 = distinct !DIGlobalVariable(name: "dev1", scope: !2, file: !3, line: 77, type: !11, isLocal: true, isDefinition: true)
!27 = !DIGlobalVariableExpression(var: !28, expr: !DIExpression())
!28 = distinct !DIGlobalVariable(name: "dev2", scope: !2, file: !3, line: 88, type: !11, isLocal: true, isDefinition: true)
!29 = !{i32 2, !"Dwarf Version", i32 4}
!30 = !{i32 2, !"Debug Info Version", i32 3}
!31 = !{i32 1, !"wchar_size", i32 4}
!32 = !{!"clang version 7.0.0 (trunk 323988) (llvm/trunk 323938)"}
!33 = distinct !DISubprogram(name: "init", scope: !3, file: !3, line: 27, type: !34, isLocal: false, isDefinition: true, scopeLine: 27, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!34 = !DISubroutineType(types: !35)
!35 = !{null, !6}
!36 = !DILocalVariable(name: "head", arg: 1, scope: !33, file: !3, line: 27, type: !6)
!37 = !DILocation(line: 27, column: 24, scope: !33)
!38 = !DILocation(line: 28, column: 10, scope: !33)
!39 = !DILocation(line: 29, column: 1, scope: !33)
!40 = distinct !DISubprogram(name: "register_device", scope: !3, file: !3, line: 31, type: !15, isLocal: false, isDefinition: true, scopeLine: 32, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!41 = !DILocalVariable(name: "dev", arg: 1, scope: !40, file: !3, line: 31, type: !10)
!42 = !DILocation(line: 31, column: 37, scope: !40)
!43 = !DILocalVariable(name: "new_node", scope: !40, file: !3, line: 34, type: !6)
!44 = !DILocation(line: 34, column: 18, scope: !40)
!45 = !DILocation(line: 34, column: 44, scope: !40)
!46 = !DILocation(line: 34, column: 29, scope: !40)
!47 = !DILocation(line: 37, column: 22, scope: !40)
!48 = !DILocation(line: 37, column: 5, scope: !40)
!49 = !DILocation(line: 37, column: 15, scope: !40)
!50 = !DILocation(line: 37, column: 20, scope: !40)
!51 = !DILocation(line: 40, column: 22, scope: !40)
!52 = !DILocation(line: 40, column: 5, scope: !40)
!53 = !DILocation(line: 40, column: 15, scope: !40)
!54 = !DILocation(line: 40, column: 20, scope: !40)
!55 = !DILocation(line: 43, column: 24, scope: !40)
!56 = !DILocation(line: 43, column: 22, scope: !40)
!57 = !DILocation(line: 44, column: 1, scope: !40)
!58 = distinct !DISubprogram(name: "open", scope: !3, file: !3, line: 46, type: !59, isLocal: false, isDefinition: true, scopeLine: 46, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!59 = !DISubroutineType(types: !60)
!60 = !{!21, !10}
!61 = !DILocalVariable(name: "dev", arg: 1, scope: !58, file: !3, line: 46, type: !10)
!62 = !DILocation(line: 46, column: 25, scope: !58)
!63 = !DILocation(line: 47, column: 2, scope: !58)
!64 = !DILocation(line: 47, column: 7, scope: !58)
!65 = !DILocation(line: 47, column: 12, scope: !58)
!66 = !DILocation(line: 48, column: 26, scope: !58)
!67 = !DILocation(line: 48, column: 31, scope: !58)
!68 = !DILocation(line: 48, column: 5, scope: !58)
!69 = !DILocation(line: 49, column: 5, scope: !58)
!70 = distinct !DISubprogram(name: "device_reset", scope: !3, file: !3, line: 52, type: !71, isLocal: false, isDefinition: true, scopeLine: 52, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!71 = !DISubroutineType(types: !72)
!72 = !{null, !73}
!73 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!74 = !DILocalVariable(name: "dev_init", arg: 1, scope: !70, file: !3, line: 52, type: !73)
!75 = !DILocation(line: 52, column: 25, scope: !70)
!76 = !DILocation(line: 53, column: 6, scope: !70)
!77 = !DILocation(line: 53, column: 15, scope: !70)
!78 = !DILocation(line: 54, column: 1, scope: !70)
!79 = distinct !DISubprogram(name: "lookup_device", scope: !3, file: !3, line: 56, type: !80, isLocal: false, isDefinition: true, scopeLine: 57, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!80 = !DISubroutineType(types: !81)
!81 = !{!10, !18}
!82 = !DILocalVariable(name: "search_name", arg: 1, scope: !79, file: !3, line: 56, type: !18)
!83 = !DILocation(line: 56, column: 38, scope: !79)
!84 = !DILocalVariable(name: "current", scope: !79, file: !3, line: 58, type: !6)
!85 = !DILocation(line: 58, column: 18, scope: !79)
!86 = !DILocation(line: 58, column: 28, scope: !79)
!87 = !DILocation(line: 59, column: 5, scope: !79)
!88 = !DILocation(line: 59, column: 12, scope: !79)
!89 = !DILocation(line: 59, column: 20, scope: !79)
!90 = !DILocation(line: 61, column: 20, scope: !91)
!91 = distinct !DILexicalBlock(scope: !92, file: !3, line: 61, column: 13)
!92 = distinct !DILexicalBlock(scope: !79, file: !3, line: 60, column: 5)
!93 = !DILocation(line: 61, column: 29, scope: !91)
!94 = !DILocation(line: 61, column: 34, scope: !91)
!95 = !DILocation(line: 61, column: 39, scope: !91)
!96 = !DILocation(line: 61, column: 13, scope: !91)
!97 = !DILocation(line: 61, column: 52, scope: !91)
!98 = !DILocation(line: 61, column: 13, scope: !92)
!99 = !DILocation(line: 62, column: 20, scope: !91)
!100 = !DILocation(line: 62, column: 29, scope: !91)
!101 = !DILocation(line: 62, column: 13, scope: !91)
!102 = !DILocation(line: 64, column: 19, scope: !91)
!103 = !DILocation(line: 64, column: 28, scope: !91)
!104 = !DILocation(line: 64, column: 17, scope: !91)
!105 = distinct !{!105, !87, !106}
!106 = !DILocation(line: 65, column: 5, scope: !79)
!107 = !DILocation(line: 66, column: 5, scope: !79)
!108 = !DILocation(line: 68, column: 1, scope: !79)
!109 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 95, type: !110, isLocal: false, isDefinition: true, scopeLine: 95, isOptimized: false, unit: !2, variables: !4)
!110 = !DISubroutineType(types: !111)
!111 = !{!21}
!112 = !DILocalVariable(name: "dev", scope: !109, file: !3, line: 96, type: !10)
!113 = !DILocation(line: 96, column: 21, scope: !109)
!114 = !DILocation(line: 97, column: 10, scope: !109)
!115 = !DILocation(line: 97, column: 5, scope: !109)
!116 = !DILocation(line: 98, column: 5, scope: !109)
!117 = !DILocation(line: 99, column: 5, scope: !109)
!118 = !DILocation(line: 100, column: 5, scope: !109)
!119 = !DILocation(line: 102, column: 11, scope: !109)
!120 = !DILocation(line: 102, column: 9, scope: !109)
!121 = !DILocation(line: 103, column: 10, scope: !109)
!122 = !DILocation(line: 103, column: 5, scope: !109)
!123 = !DILocation(line: 104, column: 11, scope: !109)
!124 = !DILocation(line: 104, column: 9, scope: !109)
!125 = !DILocation(line: 105, column: 10, scope: !109)
!126 = !DILocation(line: 105, column: 5, scope: !109)
!127 = !DILocation(line: 107, column: 5, scope: !109)
!128 = distinct !DISubprogram(name: "dev1_open", scope: !3, file: !3, line: 73, type: !15, isLocal: true, isDefinition: true, scopeLine: 73, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!129 = !DILocalVariable(name: "dev", arg: 1, scope: !128, file: !3, line: 73, type: !10)
!130 = !DILocation(line: 73, column: 38, scope: !128)
!131 = !DILocation(line: 74, column: 19, scope: !128)
!132 = !DILocation(line: 74, column: 24, scope: !128)
!133 = !DILocation(line: 74, column: 5, scope: !128)
!134 = !DILocation(line: 75, column: 1, scope: !128)
!135 = distinct !DISubprogram(name: "dev2_open", scope: !3, file: !3, line: 84, type: !15, isLocal: true, isDefinition: true, scopeLine: 84, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!136 = !DILocalVariable(name: "dev", arg: 1, scope: !135, file: !3, line: 84, type: !10)
!137 = !DILocation(line: 84, column: 38, scope: !135)
!138 = !DILocation(line: 85, column: 2, scope: !135)
!139 = !DILocation(line: 85, column: 7, scope: !135)
!140 = !DILocation(line: 85, column: 29, scope: !135)
!141 = !DILocation(line: 86, column: 1, scope: !135)
