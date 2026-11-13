import java.io.File

fun toShortPath(file: File): File {
    if (!System.getProperty("os.name").lowercase().contains("windows")) return file
    return try {
        val process = ProcessBuilder("cmd", "/c", "for %I in (\"${file.absolutePath}\") do @echo %~fsI")
            .redirectErrorStream(true)
            .start()
        val output = process.inputStream.bufferedReader().readText().trim()
        process.waitFor()
        if (output.isNotEmpty()) File(output) else file
    } catch (e: Exception) {
        file
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val shortProjectRoot = toShortPath(rootDir.parentFile)
val shortBuildDir = File(shortProjectRoot, "build")

rootProject.layout.buildDirectory.fileValue(shortBuildDir)

subprojects {
    val newSubprojectBuildDir = File(shortBuildDir, project.name)
    project.layout.buildDirectory.fileValue(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
