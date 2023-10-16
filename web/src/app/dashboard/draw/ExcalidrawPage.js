import { Suspense, useState, useEffect, useRef } from "react";
import dynamic from "next/dynamic";

export function ExcalidrawPage({
  excalidrawRef,
  exportToCanvasRef,
  changeImage,
}) {
  const [Excalidraw, setExcalidraw] = useState(null);

  useEffect(() => {
    import("@excalidraw/excalidraw")
      .then((comp) => {
        setExcalidraw(comp.Excalidraw);
        exportToCanvasRef.current = comp.exportToCanvas;
      })
      .catch((e) => {
        console.log("Error while building whiteboard.", e);
      });
  }, []);

  const UIOptions = {
    canvasActions: {
      changeViewBackgroundColor: false,
      clearCanvas: false,
      loadScene: false,
    },
  };

  return (
    <div className=" w-full h-[90%] ">
      <Suspense fallback={"loading..."}>
        {Excalidraw && (
          <>
            <Excalidraw
              ref={excalidrawRef}
              UIOptions={UIOptions}
              initalData={{ scrollToContent: false }}
            >
              <WelcomeScreen>
                <HintsToolbar />

                <LandingPageCenter>
                  <Heading>
                    <p className="text-4xl"> Welcome to the design house! </p>
                  </Heading>

                  <div className="font-[Virgil] text-sm">
                    <p className="text-gray-400">
                      1. Scribble together a rough idea.
                    </p>
                    <p className="text-gray-400">2. Describe it.</p>
                    <p className="text-gray-400">3. AI-ify it!</p>
                  </div>
                </LandingPageCenter>
              </WelcomeScreen>
            </Excalidraw>
          </>
        )}
      </Suspense>
    </div>
  );
}

const WelcomeScreen = dynamic(
  () => import("@excalidraw/excalidraw").then((mod) => mod.WelcomeScreen),
  {
    ssr: false,
  }
);

const HintsToolbar = dynamic(
  () =>
    import("@excalidraw/excalidraw").then(
      (mod) => mod.WelcomeScreen.Hints.ToolbarHint
    ),
  {
    ssr: false,
  }
);

const LandingPageCenter = dynamic(
  () =>
    import("@excalidraw/excalidraw").then((mod) => mod.WelcomeScreen.Center),
  {
    ssr: false,
  }
);

const Heading = dynamic(
  () =>
    import("@excalidraw/excalidraw").then(
      (mod) => mod.WelcomeScreen.Center.Heading
    ),
  {
    ssr: false,
  }
);
